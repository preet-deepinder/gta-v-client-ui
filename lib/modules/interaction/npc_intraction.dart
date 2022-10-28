import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_test/data/constants/constants.dart';
import 'package:html_test/modules/interaction/controller/npc_controller.dart';
import 'package:html_test/style/style.dart';
import 'package:html_test/utility/utils.dart';

class NpcIntractionUi extends ConsumerWidget {
  const NpcIntractionUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 500, minHeight: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => ref.read(npcInteractionProvider).onUpButton(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Palette.secondary.withOpacity(0.8),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(Dimension.defaultPadding),
                child: const RotatedBox(quarterTurns: 1, child: Icon(Icons.chevron_left, color: Palette.light)),
              ),
            ),
            Flexible(
              child: Container(
                color: Palette.secondary.withOpacity(0.8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Dimension.defaultPadding.height,
                    Flexible(
                      child: GridView.builder(
                        controller: ref.read(npcInteractionProvider).gridController,
                        itemCount: LocalData.npcInteractionList.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: Dimension.paddingLarge),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 80,
                        ),
                        itemBuilder: (_, index) => MaterialButton(
                          color: Palette.secondary.withOpacity(0.6),
                          shape: ContinuousRectangleBorder(
                            borderRadius: Dimension.buttonRadius,
                            side: BorderSide(color: Palette.dark.withOpacity(0.6), width: 3),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: Dimension.paddingLarge),
                          onPressed: () {},
                          child: TextView(
                            LocalData.npcInteractionList[index],
                            textAlign: TextAlign.center,
                            textType: TextType.interactionText,
                            maxLines: 5,
                            color: Palette.light,
                          ),
                        ),
                      ),
                    ),
                    Dimension.defaultPadding.height,
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => ref.read(npcInteractionProvider).onDownButton(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Palette.secondary.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: const RotatedBox(quarterTurns: 3, child: Icon(Icons.chevron_left, color: Palette.light)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
