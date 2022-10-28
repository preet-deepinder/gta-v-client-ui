import 'package:flutter/material.dart';
import 'package:html_test/style/style.dart';

class PhoneContainer extends StatelessWidget {
  const PhoneContainer({
    Key? key,
    required this.child,
    this.title,
    this.actionText,
    this.onAction,
    this.onBack,
    this.alignment,
    this.onMiddle,
  }) : super(key: key);

  final Widget child;
  final String? title, actionText;
  final VoidCallback? onAction, onBack, onMiddle;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          height: 30,
          color: Colors.grey.shade300,
          child: TextView(
            title?.toUpperCase(),
            textType: TextType.title,
            color: Colors.black,
            height: 1,
          ),
        ),
        Expanded(
          child: Align(
            alignment: alignment ?? Alignment.topLeft,
            child: Material(
              color: Colors.black.withOpacity(0.5),
              child: child,
            ),
          ),
        ),
        if (actionText != null)
          Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            height: 25,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: onAction,
                  minWidth: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextView(
                    actionText,
                    height: 1,
                    color: Palette.light,
                    textType: TextType.regular,
                  ),
                ),
                if (onMiddle != null)
                  MaterialButton(
                    onPressed: onMiddle,
                    minWidth: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Icon(
                      Icons.add,
                      color: Palette.light,
                    ),
                  ),
                MaterialButton(
                  onPressed: onBack,
                  minWidth: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextView(
                    'Back',
                    height: 1,
                    color: Palette.light,
                    textType: TextType.regular,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
