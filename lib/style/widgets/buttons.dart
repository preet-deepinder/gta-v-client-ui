import 'package:flutter/material.dart';
import 'package:html_test/style/palette.dart';
import 'package:html_test/style/widgets/text_view.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final double? hPadding;
  final double? vPadding;
  final Widget? child;
  final Color? color;
  final double? minwidth;

  const CustomButton({
    Key? key,
    this.title,
    this.child,
    this.hPadding,
    this.onTap,
    this.vPadding,
    this.minwidth,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color ?? Palette.secondary.withOpacity(0.6),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Palette.dark, width: 3),
      ),
      minWidth: minwidth ?? 0,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: hPadding ?? 20, vertical: vPadding ?? 0),
      onPressed: onTap,
      child: child ??
          TextView(
            title,
            textAlign: TextAlign.center,
            textType: TextType.interactionText,
            maxLines: 5,
            size: 18,
            color: Palette.light,
          ),
    );
  }
}
