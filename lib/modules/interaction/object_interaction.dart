import 'package:flutter/material.dart';
import 'package:html_test/data/constants/constants.dart';

import '../../style/widgets/text_view.dart';

class ObjectIntractionUi extends StatelessWidget {
  const ObjectIntractionUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 500, minHeight: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black45],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const RotatedBox(quarterTurns: 1, child: Icon(Icons.chevron_left, color: Colors.white)),
            ),
            Flexible(
              child: Container(
                color: Colors.black45,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Flexible(
                      child: GridView.builder(
                        itemCount: LocalData.objectInteractionList.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 80,
                        ),
                        itemBuilder: (_, index) => MaterialButton(
                          color: Colors.black54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(color: Colors.white70, width: 2),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          onPressed: () {},
                          child: TextView(
                            LocalData.objectInteractionList[index],
                            textAlign: TextAlign.center,
                            textType: TextType.interactionText,
                            maxLines: 5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.transparent, Colors.black45],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const RotatedBox(quarterTurns: 3, child: Icon(Icons.chevron_left, color: Colors.white)),
            ),
            //   Container(
            //     color: Colors.black54,
            //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //     child: Row(
            //       children: const [
            //         Text('List', style: TextStyle(color: Colors.white)),
            //         Spacer(),
            //         Text('/', style: TextStyle(color: Colors.white)),
            //         RotatedBox(quarterTurns: 3, child: Icon(Icons.chevron_left, color: Colors.white)),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
