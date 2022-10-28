import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_test/data/constants/constants.dart';
import 'package:html_test/data/constants/enums.dart';
import 'package:html_test/data/constants/request_model.dart';
import 'package:html_test/data/injectors/sender_injection.dart';
import 'package:html_test/modules/cell_phone/controller/phone_controller.dart';
import 'package:html_test/style/style.dart';
import 'package:html_test/style/widgets/containers.dart';
import 'package:html_test/style/widgets/text_field.dart';
import 'package:html_test/utility/extensions/num_extension.dart';
import 'package:html_test/utility/input_formatter.dart';

class PhoneUi extends ConsumerStatefulWidget {
  const PhoneUi({Key? key}) : super(key: key);

  @override
  ConsumerState<PhoneUi> createState() => _PhoneUiState();
}

class _PhoneUiState extends ConsumerState<PhoneUi> {
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController numberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();
  final TextEditingController emailToController = TextEditingController();
  final TextEditingController emailSubjectController = TextEditingController();
  final TextEditingController emailBodyController = TextEditingController();
  final TextEditingController messageToController = TextEditingController();
  final TextEditingController messagebodyController = TextEditingController();

  final double _screenHeight = 250, _screenWidth = 210;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  Widget _secondWidget = Container();
  Widget _thirdWidget = Container();
  Widget? _optionWidget;

  bool _isDialogVisible = false;
  bool _optionsDialog = false;
  String _dialogText = '';
  String _subHeading = '';
  String _buttonText = '';
  IconData _dialogIcon = Icons.check_circle;

  void onNext() {
    _pageController.nextPage(
      duration: _animationDuration,
      curve: Curves.ease,
    );
  }

  void onBack() {
    _pageController.previousPage(
      duration: _animationDuration,
      curve: Curves.ease,
    );
    numberController.clear();
    nameController.clear();
    emailToController.clear();
    emailSubjectController.clear();
    emailBodyController.clear();
    contactEmailController.clear();
    messageToController.clear();
    messagebodyController.clear();
  }

  void _showDialog({String? heading, String? subHeading, IconData? icon, String? buttonText}) {
    _isDialogVisible = true;
    _dialogText = heading ?? "";
    _subHeading = subHeading ?? "";
    _dialogIcon = icon ?? Icons.check_circle;
    _buttonText = buttonText ?? "";
  }

  void showOption({Widget? optionWidget}) {
    _optionWidget = optionWidget;
  }

  @override
  Widget build(BuildContext context) {
    final read = ref.read(phoneController);
    final watch = ref.watch(phoneController);

    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: size.height - 435,
            left: size.width - 280,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SvgPicture.asset(
                LocalAsset.phone2Svg,
                height: 435,
                width: 260,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
              // Image.asset(Constant.phonePng, height: 590, width: 260),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: TextView(
                  'AtomAttic'.toUpperCase(),
                  size: 12,
                  height: 1,
                  color: Colors.white,
                  letterSpacing: 2,
                  textType: TextStyle(
                    fontFamily: GoogleFonts.jacquesFrancoisShadow().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: _screenWidth,
                height: _screenHeight,
                margin: const EdgeInsets.only(top: 70.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 3, color: Colors.black),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLa31PV127xusJye8icXIcQHOt5Lh4xy-MGQ&usqp=CAU',
                      fit: BoxFit.cover,
                      height: double.maxFinite,
                      width: double.maxFinite,
                    ),
                    Container(
                      height: _screenHeight,
                      width: _screenWidth,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 20,
                          color: Colors.black.withOpacity(0.7),
                          child: IconTheme(
                            data: const IconThemeData(
                              color: Palette.light,
                              size: 14,
                            ),
                            child: Row(
                              children: [
                                5.0.width,
                                const Spacer(),
                                const Icon(Icons.no_sim_rounded),
                                5.0.width,
                                const Icon(Icons.signal_cellular_4_bar_sharp),
                                5.0.width,
                                const Icon(Icons.battery_5_bar),
                                5.0.width,
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            pageSnapping: true,
                            physics: kReleaseMode ? const NeverScrollableScrollPhysics() : null,
                            children: [
                              _buildHomeScreen(read),
                              _secondWidget,
                              _thirdWidget,
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_isDialogVisible)
                      Container(
                        color: Colors.black87,
                        padding: const EdgeInsets.all(20.0).add(
                          const EdgeInsets.only(top: 20),
                        ),
                        child: Material(
                          color: Palette.dark,
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Spacer(),
                              Icon(
                                _dialogIcon,
                                color: Colors.green,
                                size: 62,
                              ),
                              10.0.height,
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextView(
                                  _dialogText.toUpperCase(),
                                  color: Palette.light,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  size: 13,
                                  height: 1,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: TextView(
                                  _subHeading.toUpperCase(),
                                  color: Palette.light,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  size: 15,
                                  height: 1,
                                ),
                              ),
                              const Spacer(),
                              MaterialButton(
                                color: Colors.transparent,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                child: TextView(_buttonText),
                                onPressed: () => setState(() => _isDialogVisible = false),
                              )
                            ],
                          ),
                        ),
                      ),
                    if (_optionsDialog)
                      Container(
                        color: Colors.black87,
                        padding: const EdgeInsets.all(10.0).add(
                          const EdgeInsets.only(top: 20),
                        ),
                        child: Material(
                          color: Palette.dark,
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Center(
                                  child: TextView(
                                    "Options",
                                    color: Palette.light,
                                    size: 18,
                                  ),
                                ),

                                const Divider(
                                  color: Palette.light,
                                  thickness: 2,
                                ),

                                _optionWidget ?? const SizedBox(),
                                //  const Spacer(),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                                //   child: TextView(
                                //     "_dialogText".toUpperCase(),
                                //     color: Palette.light,
                                //     textAlign: TextAlign.center,
                                //     maxLines: 2,
                                //     size: 15,
                                //     height: 1,
                                //   ),
                                // ),
                                // const Spacer(),
                                MaterialButton(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  padding: EdgeInsets.zero,
                                  child: const TextView("Dismiss"),
                                  onPressed: () => setState(() => _optionsDialog = false),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: GestureDetector(
            onSecondaryTapUp: (i) => onBack(),
          ),
        ),
      ],
    );
  }

  Widget _buildHomeScreen(PhoneController read) {
    return GridView.builder(
      itemCount: LocalData.phoneMenuList.length,
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) => Material(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
        clipBehavior: Clip.antiAlias,
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) {
            // debugPrint('event.physicalKey.debugName: $event.physicalKey.debugName');
            // if (event.isMetaPressed == 4294967309) {
            //   print("asdadda");
            // }
          },
          child: InkWell(
            onTap: () => _secondScreensFunc(index, read),
            hoverColor: Colors.green,
            highlightColor: Colors.lightGreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  [
                    Icons.email,
                    Icons.sms,
                    Icons.phone,
                    Icons.person,
                    Icons.camera,
                    Icons.wifi,
                    Icons.settings,
                  ][index],
                  size: 30,
                  color: Colors.white,
                ),
                const SizedBox.square(dimension: 2),
                Text(
                  LocalData.phoneMenuList[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _secondScreensFunc(int i, PhoneController read) {
    switch (i) {
      case 0:
        _secondWidget = PhoneContainer(
          title: 'Email',
          actionText: 'Read',
          onAction: () {},
          onBack: onBack,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: false,
              itemCount: LocalData.emailMenu.length,
              itemBuilder: (context, indexx) {
                return InkWell(
                  onTap: () {
                    switch (indexx) {
                      case 0:
                        _thirdWidget = PhoneContainer(
                          title: 'compose email',
                          actionText: 'Send',
                          onAction: () {
                            if (kReleaseMode) {
                              final reqModel = RequestModel(
                                to: emailToController.text,
                                subject: emailSubjectController.text,
                                body: emailBodyController.text,
                              );
                              emit(Pub.SEND_EMAIL, reqModel);
                            }
                          },
                          onBack: onBack,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _thirdWidget = PhoneContainer(
                                      title: 'contacts',
                                      actionText: 'Select',
                                      onAction: () {},
                                      alignment: Alignment.topLeft,
                                      onBack: onBack,
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: LocalData.contactList.length,
                                          itemBuilder: (context, ix) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  ///////////// When user select CONTACT to send EMAIL//////
                                                  ///
                                                  switch (indexx) {
                                                    case 0:
                                                      _thirdWidget = _thirdWidget = PhoneContainer(
                                                        title: 'compose mail',
                                                        actionText: 'Send',
                                                        onAction: () {
                                                          if (kReleaseMode) {
                                                            final reqModel = RequestModel(
                                                              to: messageToController.text,
                                                              body: messagebodyController.text,
                                                            );
                                                            emit(Pub.SEND_TEXT, reqModel);
                                                          }
                                                        },
                                                        onBack: onBack,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(10.0),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              CustomTextField(
                                                                enableField: false,
                                                                controller: emailToController,
                                                                hintText: 'To: ',
                                                              ),
                                                              const Spacer(),
                                                              CustomTextField(
                                                                controller: emailSubjectController,
                                                                hintText: 'Subject:',
                                                              ),
                                                              const Spacer(),
                                                              CustomTextField(
                                                                controller: emailBodyController,
                                                                hintText: 'Write here...',
                                                                maxlines: 3,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );

                                                      emailToController.text = LocalData.contactList[ix];
                                                      setState(() {});
                                                      onNext();
                                                      break;
                                                    default:
                                                  }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                                  child: TextView(
                                                    LocalData.contactList[ix],
                                                    color: Palette.light,
                                                    textType: TextType.regular,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                    setState(() {});
                                  },
                                  child: CustomTextField(
                                    enableField: false,
                                    hintText: 'To: ',
                                    controller: emailToController,
                                  ),
                                ),
                                const Spacer(),
                                CustomTextField(
                                  hintText: 'Subject: ',
                                  controller: emailSubjectController,
                                ),
                                const Spacer(),
                                CustomTextField(
                                  hintText: 'Write Here...',
                                  maxlines: 3,
                                  controller: emailBodyController,
                                )
                              ],
                            ),
                          ),
                        );
                        break;
                      case 1:
                        _thirdWidget = PhoneContainer(
                          title: 'inbox',
                          actionText: 'Read',
                          onAction: () {},
                          onBack: onBack,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: LocalData.inboxMsgList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.email,
                                          color: Palette.light,
                                          size: 20,
                                        ),
                                        10.0.width,
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextView(
                                                LocalData.inboxMsgConatact[index],
                                                color: Palette.light,
                                                textType: TextType.regular,
                                                size: TextSize.regularLarge,
                                                letterSpacing: 1.2,
                                              ),
                                              4.0.height,
                                              TextView(
                                                LocalData.inboxMsgList[index],
                                                color: Palette.light,
                                                textType: TextType.regular,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                        break;
                      case 2:
                        _thirdWidget = PhoneContainer(
                          title: 'Outbox',
                          actionText: 'Read',
                          onAction: () {},
                          onBack: onBack,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: LocalData.sentBoxMsgList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.email,
                                          color: Palette.light,
                                          size: 20,
                                        ),
                                        10.0.width,
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.all(2),
                                            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextView(
                                                  LocalData.inboxMsgConatact[index],
                                                  color: Palette.light,
                                                  textType: TextType.regular,
                                                  size: 18,
                                                ),
                                                TextView(
                                                  LocalData.sentBoxMsgList[index],
                                                  color: Palette.light,
                                                  textType: TextType.regular,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                        break;
                      default:
                        _thirdWidget = Container(
                          color: Colors.black,
                        );
                        break;
                    }

                    setState(() {});
                    onNext();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: TextView(
                      LocalData.emailMenu[indexx],
                      color: Palette.light,
                      textType: TextType.regular,
                    ),
                  ),
                );
              }),
        );
        break;
      case 1:
        _secondWidget = PhoneContainer(
          title: 'sms',
          actionText: 'Read',
          onAction: () {},
          alignment: Alignment.topLeft,
          onBack: onBack,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: LocalData.msgMenuList.length,
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          _thirdWidget = PhoneContainer(
                            title: 'create message',
                            actionText: 'Send',
                            onAction: () {
                              if (kReleaseMode) {
                                final reqModel = RequestModel(
                                  to: messageToController.text,
                                  body: messagebodyController.text,
                                );
                                emit(Pub.SEND_TEXT, reqModel);
                              }
                            },
                            onBack: onBack,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _thirdWidget = PhoneContainer(
                                        title: 'contacts',
                                        actionText: 'Select',
                                        onAction: () {},
                                        alignment: Alignment.topLeft,
                                        onBack: onBack,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: LocalData.contactList.length,
                                            itemBuilder: (context, ix) {
                                              return Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    ///////////// When user select CONTACT to send MESSAGE//////
                                                    ///
                                                    switch (index) {
                                                      case 0:
                                                        _thirdWidget = _thirdWidget = PhoneContainer(
                                                          title: 'create message',
                                                          actionText: 'Send',
                                                          onAction: () {
                                                            if (kReleaseMode) {
                                                              final reqModel = RequestModel(
                                                                to: messageToController.text,
                                                                body: messagebodyController.text,
                                                              );
                                                              emit(Pub.SEND_TEXT, reqModel);
                                                            }
                                                          },
                                                          onBack: onBack,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(10.0),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: [
                                                                CustomTextField(
                                                                  enableField: false,
                                                                  controller: messageToController,
                                                                  hintText: 'To: ',
                                                                ),
                                                                const Spacer(),
                                                                CustomTextField(
                                                                  controller: messagebodyController,
                                                                  hintText: 'Write here...',
                                                                  maxlines: 3,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );

                                                        messageToController.text = LocalData.contactList[ix];
                                                        setState(() {});
                                                        onNext();
                                                        break;
                                                      default:
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                                    child: TextView(
                                                      LocalData.contactList[ix],
                                                      color: Palette.light,
                                                      textType: TextType.regular,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                      setState(() {});
                                    },
                                    child: CustomTextField(
                                      enableField: false,
                                      hintText: 'To: ',
                                      controller: emailToController,
                                    ),
                                  ),
                                  const Spacer(),
                                  CustomTextField(
                                    controller: messagebodyController,
                                    hintText: 'Enter Message',
                                    maxlines: 4,
                                  )
                                ],
                              ),
                            ),
                          );
                          break;
                        case 1:
                          _thirdWidget = PhoneContainer(
                            title: 'inbox',
                            actionText: 'Read',
                            onAction: () {},
                            onBack: onBack,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: LocalData.inboxMsgList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.chat,
                                            color: Palette.light,
                                            size: 20,
                                          ),
                                          10.0.width,
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextView(
                                                  LocalData.inboxMsgConatact[index],
                                                  color: Palette.light,
                                                  textType: TextType.regular,
                                                  size: TextSize.regularLarge,
                                                  letterSpacing: 1.2,
                                                ),
                                                4.0.height,
                                                TextView(
                                                  LocalData.inboxMsgList[index],
                                                  color: Palette.light,
                                                  textType: TextType.regular,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                          break;
                        case 2:
                          _thirdWidget = PhoneContainer(
                            title: 'Outbox',
                            actionText: 'Read',
                            onAction: () {},
                            onBack: onBack,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: LocalData.sentBoxMsgList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.chat,
                                            color: Palette.light,
                                            size: 20,
                                          ),
                                          10.0.width,
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.all(2),
                                              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextView(
                                                    LocalData.inboxMsgConatact[index],
                                                    color: Palette.light,
                                                    textType: TextType.regular,
                                                    size: 18,
                                                  ),
                                                  TextView(
                                                    LocalData.sentBoxMsgList[index],
                                                    color: Palette.light,
                                                    textType: TextType.regular,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                          break;
                        default:
                          _thirdWidget = Container(
                            color: Colors.black,
                          );
                          break;
                      }

                      setState(() {});
                      onNext();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      child: TextView(
                        LocalData.msgMenuList[index],
                        color: Palette.light,
                        textType: TextType.regular,
                      ),
                    ),
                  ),
                );
              }),
        );
        break;
      case 2:
        _secondWidget = PhoneContainer(
          title: 'Phone',
          actionText: 'Dial',
          onAction: () {
            if (numberController.text.isNotEmpty) {
              if (kReleaseMode) {
                final reqModel = RequestModel(phoneNumber: numberController.text);
                emit(Pub.MAKE_CALL, reqModel);
              }
              _showDialog(
                icon: Icons.call,
                heading: "Dialing...\n${numberController.text}",
                buttonText: "Disconnect",
              );
              setState(() {});
            } else {
              return;
            }
          },
          onMiddle: () {
            _thirdWidget = PhoneContainer(
              title: 'Create Contact',
              actionText: 'Save',
              onAction: () {
                if (numberController.text.isNotEmpty && nameController.text.isNotEmpty) {
                  setState(() {});
                  if (kReleaseMode) {
                    final reqModel = RequestModel(
                      name: nameController.text,
                      phoneNumber: numberController.text,
                      email: contactEmailController.text,
                    );
                    emit(Pub.SAVE_CONTACT, reqModel);
                  }
                  _showDialog(heading: "Contact Saved", buttonText: "Dismiss");
                  setState(() {});
                } else {
                  return;
                }
              },
              onBack: onBack,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8).add(const EdgeInsets.only(top: 8)),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: nameController,
                      hintText: "Enter Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: numberController,
                      hintText: "Enter Phone Number",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: contactEmailController,
                      hintText: "Enter Email",
                    ),
                  ],
                ),
              ),
            );
            setState(() {});
            onNext();
          },
          alignment: Alignment.topLeft,
          onBack: onBack,
          child: TextField(
            controller: numberController,
            textAlign: TextAlign.start,
            autofocus: true,
            maxLines: 5,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9),
              MaskedTextInputFormatter(),
            ],
            style: const TextStyle(color: Colors.white, fontSize: 36, letterSpacing: 3),
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
        );
        break;
      case 3:
        _secondWidget = PhoneContainer(
          title: 'contacts',
          actionText: 'Dial',
          onAction: () {},
          alignment: Alignment.topLeft,
          onBack: onBack,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: LocalData.contactList.length,
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _optionsDialog = true;
                      showOption(
                        optionWidget: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: LocalData.optionList.length,
                            itemBuilder: (context, idx) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    switch (idx) {
                                      case 0:
                                        _optionsDialog = false;
                                        _showDialog(
                                          icon: Icons.call,
                                          heading: "Calling ...",
                                          subHeading: LocalData.contactList[index],
                                          buttonText: 'Disconnect',
                                        );
                                        setState(() {});

                                        // _secondWidget = PhoneContainer(
                                        //   title: 'contacts',
                                        //   actionText: 'Dial',
                                        //   onAction: () {},
                                        //   alignment: Alignment.topLeft,
                                        //   onBack: onBack,
                                        //   child: Text("dsdsd"),
                                        // );
                                        break;
                                      case 1:
                                        _thirdWidget = _thirdWidget = PhoneContainer(
                                          title: 'create message',
                                          actionText: 'Send',
                                          onAction: () {
                                            if (kReleaseMode) {
                                              final reqModel = RequestModel(
                                                to: messageToController.text,
                                                body: messagebodyController.text,
                                              );
                                              emit(Pub.SEND_TEXT, reqModel);
                                            }
                                          },
                                          onBack: onBack,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                CustomTextField(
                                                  enableField: false,
                                                  controller: messageToController,
                                                  hintText: 'To: ',
                                                ),
                                                const Spacer(),
                                                CustomTextField(
                                                  controller: messagebodyController,
                                                  hintText: 'Enter Message',
                                                  maxlines: 4,
                                                )
                                              ],
                                            ),
                                          ),
                                        );

                                        _optionsDialog = false;
                                        messageToController.text = LocalData.contactList[index];
                                        setState(() {});
                                        onNext();
                                        break;
                                      case 2:
                                        _thirdWidget = _thirdWidget = PhoneContainer(
                                          title: 'compose mail',
                                          actionText: 'Send',
                                          onAction: () {
                                            if (kReleaseMode) {
                                              final reqModel = RequestModel(
                                                to: messageToController.text,
                                                body: messagebodyController.text,
                                              );
                                              emit(Pub.SEND_TEXT, reqModel);
                                            }
                                          },
                                          onBack: onBack,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                CustomTextField(
                                                  enableField: false,
                                                  controller: emailToController,
                                                  hintText: 'To: ',
                                                ),
                                                const Spacer(),
                                                CustomTextField(
                                                  controller: emailSubjectController,
                                                  hintText: 'Subject:',
                                                ),
                                                const Spacer(),
                                                CustomTextField(
                                                  controller: emailBodyController,
                                                  hintText: 'Write here...',
                                                  maxlines: 3,
                                                )
                                              ],
                                            ),
                                          ),
                                        );

                                        _optionsDialog = false;
                                        emailToController.text = LocalData.contactList[index];
                                        setState(() {});
                                        onNext();
                                        break;
                                      default:
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                    child: TextView(
                                      LocalData.optionList[idx],
                                      color: Palette.light,
                                      textType: TextType.regular,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      child: TextView(
                        LocalData.contactList[index],
                        color: Palette.light,
                        textType: TextType.regular,
                      ),
                    ),
                  ),
                );
              }),
        );
        break;

      case 4:
        _secondWidget = Container(
          color: Colors.pink,
        );
        break;
      case 5:
        _secondWidget = Container(
          color: Colors.green,
        );
        break;
      default:
        _secondWidget = Container(
          color: Colors.black,
        );
        break;
    }
    setState(() {});
    onNext();
  }
}
