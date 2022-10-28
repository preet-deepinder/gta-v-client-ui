import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:html_test/utility/utils.dart';

import '../palette.dart';
import 'text_view.dart';

class InfoDialogBox extends StatelessWidget {
  const InfoDialogBox({super.key, this.icon, this.infoText, this.buttonText, this.onPressed});
  final IconData? icon;
  final String? infoText;
  final String? buttonText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
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
              icon,
              color: Colors.green,
              size: 62,
            ),
            10.0.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextView(
                infoText ?? "".toUpperCase(),
                color: Palette.light,
                textAlign: TextAlign.center,
                maxLines: 2,
                size: 15,
                height: 1,
              ),
            ),
            const Spacer(),
            MaterialButton(color: Colors.transparent, elevation: 0, padding: EdgeInsets.zero, child: TextView(buttonText ?? ""), onPressed: onPressed)
          ],
        ),
      ),
    );
  }
}
