import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_test/data/constants/assets.dart';
import 'package:html_test/data/constants/enums.dart';
import 'package:html_test/data/injectors/receiver_injection.dart';
import 'package:html_test/data/models/character_data_model.dart';
import 'package:html_test/modules/cell_phone/phone.dart';
import 'package:html_test/modules/interaction/npc_intraction.dart';
import 'package:html_test/modules/user_inventory/user_inventory.dart';
import 'package:html_test/style/palette.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
      visualDensity: VisualDensity.standard,
      splashFactory: NoSplash.splashFactory,
      scaffoldBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      primaryColor: Palette.primary,
      // focusColor: Palette.accentColor,
      // hoverColor: Palette.accentColor,
      focusColor: Palette.accent,
      hoverColor: Palette.accent,
    );

    // altOn('event', (i) {});

    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: themeData,
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            if (kDebugMode)
              Image.asset(
                LocalAsset.scene2,
                fit: BoxFit.cover,
                height: double.maxFinite,
                width: double.maxFinite,
              ),
            const UserInventoryUi(),
          ],
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  dynamic _showPhone;
  dynamic _showInteraction;
  dynamic _faceNames;
  dynamic _faceNames2;
  CharacterDataResModel? _charDataResult;

  @override
  void initState() {
    super.initState();

    if (kReleaseMode) {
      altOn(Sub.PHONE.name, (i) {
        debugPrint('PHONE: $i');
        if (i != null) {
          setState(() {
            _showPhone = i;
            _showInteraction = null;
            _faceNames = null;
            _faceNames2 = null;
          });
        }
      });
      altOn('INTERACTION', (i) {
        debugPrint('INTERACTION: $i');
        if (i != null) {
          setState(() {
            _showInteraction = i;
            _showPhone = null;
            _faceNames = null;
            _faceNames2 = null;
          });
        }
      });
      altOn(CharacterCreator.HEAD_BLEND_AND_EYES.name, (i) {
        debugPrint('first_screen: $i');
        _charDataResult = CharacterDataResModel.fromJson(jsonDecode(i));
        debugPrint('_charDataResult: $_charDataResult');
        setState(() {
          _showPhone = null;
          _showInteraction = null;
          _faceNames2 = null;
        });
      });
      // altOnList('screen2', (i) {
      //   debugPrint('FACE_NAMES_DATA');
      //   try {
      //     debugPrint('FACE_NAMES: $i');
      //   } catch (e) {
      //     debugPrint('exception: $e');
      //     throw Exception(e);
      //   }
      // setState(() {
      //   _faceNames = i;
      //   _showPhone = null;
      //   _showInteraction = null;
      // });
      // });

    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showPhone != null) {
      return const PhoneUi();
    } else if (_showInteraction != null) {
      return const NpcIntractionUi();
      // } else if (false) {
      //   return CharacterCreation(charData: _charDataResult);
      // } else if (true) {
      ////  return CharacterCreation(charData: _charDataResult);
    } else {
      return const SizedBox();
    }
  }
}
