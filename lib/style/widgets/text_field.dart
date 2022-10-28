import 'package:flutter/material.dart';
import 'package:html_test/style/palette.dart';
import 'text_view.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.maxlines,
    this.hPadding,
    this.vPadding,
    this.isdense,
    this.enableField,
  });
  final TextEditingController? controller;
  final String? hintText;
  final int? maxlines;
  final double? hPadding;
  final double? vPadding;
  final bool? isdense;
  final bool? enableField;
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enableField,
      controller: controller,
      maxLines: maxlines ?? 1,
      showCursor: true,
      cursorWidth: 3,
      cursorHeight: 18,
      cursorColor: Palette.accent,
      mouseCursor: MouseCursor.defer,
      style: TextType.regular.apply(color: Palette.light, heightFactor: 1.2),
      textAlign: TextAlign.start,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      autofocus: isdense ?? true,
      decoration: InputDecoration(
        isDense: true,
        constraints: const BoxConstraints(
          minHeight: 0,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: hPadding ?? 10.0, vertical: vPadding ?? 8),
        hintText: hintText,
        hintStyle: TextType.regular.apply(color: Palette.light),
        filled: true,
        fillColor: Palette.dark,
        border: InputBorder.none,
      ),
    );
  }
}
