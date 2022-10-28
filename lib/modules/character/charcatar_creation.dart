import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_test/data/models/character_data_model.dart';
import 'package:html_test/modules/character/controller/cc_controller.dart';
import 'package:html_test/style/palette.dart';

import '../../style/dimensions.dart';
import '../../style/widgets/buttons.dart';
import '../../style/widgets/choose_design.dart';
import '../../style/widgets/text_view.dart';

final faceMixProvider = StateNotifierProvider<FaceMixNotifier, double>(
  (_) => FaceMixNotifier(),
);

class FaceMixNotifier extends StateNotifier<double> {
  FaceMixNotifier() : super(0.5);

  final double minValue = 0.0;
  final double maxValue = 1.0;

  void onValueChange(double value) => state = value;
}

final skinMixProvider = StateNotifierProvider<SkinMixNotifier, double>(
  (_) => SkinMixNotifier(),
);

class SkinMixNotifier extends StateNotifier<double> {
  SkinMixNotifier() : super(0.5);

  final double minValue = 0.0;
  final double maxValue = 1.0;

  void onValueChange(double value) => state = value;
}

class CharacterCreation extends ConsumerWidget {
  const CharacterCreation({Key? key, this.charData}) : super(key: key);

  final CharacterDataResModel? charData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rProvider = ref.read(ccProvider);
    final wProvider = ref.watch(ccProvider);

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Palette.secondary.withOpacity(0.8),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      constraints: const BoxConstraints(maxWidth: 600, minHeight: 0),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: ref.watch(ccProvider).pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _firstPage(rProvider, wProvider, ref),
                _secondPage(rProvider, wProvider),
                _thirdPage(ref),
              ],
            ),
          ),
          _navigationButton(wProvider, ref)
        ],
      ),
    );
  }

  Row _navigationButton(CharactarCreationChangeProvider wProvider, WidgetRef ref) {
    return Row(
      children: [
        if (wProvider.currentPage != 1)
          Expanded(
            child: CustomButton(
              title: "Back",
              color: Palette.primary,
              onTap: ref.read(ccProvider).onBackButton,
            ),
          ),
        if (wProvider.currentPage != 1) const SizedBox(width: 10.0),
        Expanded(
          child: CustomButton(
            title: "Next",
            onTap: ref.read(ccProvider).onNextButton,
          ),
        ),
      ],
    );
  }

  ListView _secondPage(CharactarCreationChangeProvider rProvider, CharactarCreationChangeProvider wProvider) {
    return ListView(
      shrinkWrap: false,
      padding: EdgeInsets.zero,
      controller: ScrollController(),
      children: [
        ChooseListTile(
          label: "Blemishes",
          list: List.generate(23, (index) => '${index + 1}'),
          onChanged: rProvider.onBlemishes,
        ),
        ChooseListTile(
          label: "Facial Hair",
          list: List.generate(28, (index) => '${index + 1}'),
          onChanged: rProvider.onFacialHair,
        ),
        ChooseListTile(
          label: "Eyebrow",
          list: List.generate(33, (index) => '${index + 1}'),
          onChanged: rProvider.onEyebrow,
        ),
        ChooseListTile(
          label: "Ageing",
          list: List.generate(14, (index) => '${index + 1}'),
          onChanged: rProvider.onAgeing,
        ),
        ChooseListTile(
          label: "Make Up",
          list: List.generate(74, (index) => '${index + 1}'),
          onChanged: rProvider.onMakeUp,
        ),
        ChooseListTile(
          label: "Blush",
          list: List.generate(6, (index) => '${index + 1}'),
          onChanged: rProvider.onBlush,
        ),
        ChooseListTile(
          label: "Complexion",
          list: List.generate(11, (index) => '${index + 1}'),
          onChanged: rProvider.onComplexion,
        ),
        ChooseListTile(
          label: "Sun Damage",
          list: List.generate(10, (index) => '${index + 1}'),
          onChanged: rProvider.onSunDamage,
        ),
        ChooseListTile(
          label: "Lipstick",
          list: List.generate(9, (index) => '${index + 1}'),
          onChanged: rProvider.onLipstick,
        ),
        ChooseListTile(
          label: "Moles/Freckles ",
          list: List.generate(17, (index) => '${index + 1}'),
          onChanged: rProvider.onMoles,
        ),
        ChooseListTile(
          label: "Chest Hairs",
          list: List.generate(16, (index) => '${index + 1}'),
          onChanged: rProvider.onChestHairs,
        ),
        ChooseListTile(
          label: "Body Blemishes",
          list: List.generate(11, (index) => '${index + 1}'),
          onChanged: rProvider.onBodyBlemishes,
        ),
        ChooseListTile(
          label: "Add Body Blemishes",
          list: const ['Disabled', 'Enabled'],
          onChanged: rProvider.addBodyBlemishes,
        ),
      ],
    );
  }

  ListView _firstPage(CharactarCreationChangeProvider rProvider, CharactarCreationChangeProvider wProvider, WidgetRef ref) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: false,
      controller: ScrollController(),
      children: [
        ChooseListTile(
          label: 'Gender',
          list: const ['Male', 'Female'],
          showCounter: false,
          onChanged: rProvider.onGender,
        ),
        Material(
          color: Palette.secondary.withOpacity(0.6),
          shape: ContinuousRectangleBorder(
            borderRadius: Dimension.buttonRadius,
            side: BorderSide(color: Palette.dark.withOpacity(0.6), width: 3),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: TextView(
                      "Face Shape",
                      size: 22,
                      color: Palette.light,
                    ),
                  ),
                ),
                ChooseListTile(
                  label: "Father",
                  list: charData?.fatherNames,
                  onChanged: rProvider.onFathershape,
                ),
                ChooseListTile(
                  label: "Mother",
                  list: charData?.motherNames,
                  onChanged: rProvider.onMothershape,
                ),
                Material(
                  color: Palette.secondary.withOpacity(0.6),
                  shape: ContinuousRectangleBorder(
                    borderRadius: Dimension.buttonRadius,
                    side: BorderSide(color: Palette.dark.withOpacity(0.6), width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextView(
                              "Face Mix",
                              color: Colors.white,
                              size: 18,
                            ),
                            TextView(
                              "${ref.watch(faceMixProvider).toStringAsFixed(2)}/1.00",
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                        Slider(
                          thumbColor: Colors.green,
                          activeColor: Colors.grey,
                          value: ref.watch(faceMixProvider),
                          onChanged: (i) {
                            ref.read(faceMixProvider.notifier).onValueChange(i);
                            rProvider.onShapeMix(i);
                          },
                          min: ref.watch(faceMixProvider.notifier).minValue,
                          max: ref.watch(faceMixProvider.notifier).maxValue,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Material(
          color: Palette.secondary.withOpacity(0.6),
          shape: ContinuousRectangleBorder(
            borderRadius: Dimension.buttonRadius,
            side: BorderSide(color: Palette.dark.withOpacity(0.6), width: 3),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: TextView(
                      "Skin Type  ",
                      size: 22,
                      color: Palette.light,
                    ),
                  ),
                ),
                ChooseListTile(
                  label: "Father",
                  list: charData?.fatherNames,
                  onChanged: rProvider.onFatherSkin,
                ),
                ChooseListTile(
                  label: "Mother",
                  list: charData?.motherNames,
                  onChanged: rProvider.onMotherSkin,
                ),
                Material(
                  color: Palette.secondary.withOpacity(0.6),
                  shape: ContinuousRectangleBorder(
                    borderRadius: Dimension.buttonRadius,
                    side: BorderSide(color: Palette.dark.withOpacity(0.6), width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextView(
                              'Skin Mix',
                              color: Colors.white,
                              size: 18,
                            ),
                            TextView(
                              "${ref.watch(skinMixProvider).toStringAsFixed(2)}/1.00",
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                        Slider(
                          thumbColor: Colors.green,
                          activeColor: Colors.grey,
                          value: ref.watch(skinMixProvider),
                          onChanged: (i) {
                            ref.read(skinMixProvider.notifier).onValueChange(i);
                            rProvider.onSkinMix(i);
                          },
                          min: ref.watch(skinMixProvider.notifier).minValue,
                          max: ref.watch(skinMixProvider.notifier).maxValue,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ChooseListTile(
          label: 'Hairs',
          list: wProvider.gender == 0 ? charData?.maleHairs : charData?.femaleHairs,
          onChanged: rProvider.onHairs,
          list2: const ['Red', 'Green', 'Blue'],
          onChanged2: rProvider.onHairs,
        ),
        ChooseListTile(
          label: 'Eyes',
          list: charData?.eyes,
          onChanged: rProvider.onEyes,
        ),
      ],
    );
  }

  Widget _thirdPage(WidgetRef ref) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: false,
      controller: ScrollController(),
      children: const [
        ChooseListTile(
          label: "Shirt",
        ),
        ChooseListTile(
          label: "T-Shirt",
        ),
        ChooseListTile(
          label: "Jacket",
        ),
        ChooseListTile(
          label: "Pant",
        ),
        ChooseListTile(
          label: "Shoes",
        ),
        ChooseListTile(
          label: "Hat",
        ),
        ChooseListTile(
          label: "Watch",
        ),
      ],
    );
  }
}
