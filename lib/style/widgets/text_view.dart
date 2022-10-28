import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextType {
  static TextStyle regular = TextStyle(
    fontSize: TextSize.regular,
    height: 1,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.lato().fontFamily,
  );

  static TextStyle interactionText = TextStyle(
    height: 1,
    fontSize: TextSize.interaction,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.lato().fontFamily,
  );

  static TextStyle regularBold = TextStyle(
    height: 1,
    fontSize: TextSize.regular,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.lato().fontFamily,
  );

  static TextStyle title = TextStyle(
    height: 1,
    fontSize: TextSize.title,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.lato().fontFamily,
  );

  static TextStyle subtitle = TextStyle(
    height: 1,
    fontSize: TextSize.subtitle,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.lato().fontFamily,
  );

  static TextStyle button = TextStyle(
    height: 1,
    fontSize: TextSize.button,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.lato().fontFamily,
  );
}

class TextSize {
  TextSize._();
  static const double regularSmall = 12;
  static const double regular = 14;
  static const double regularLarge = 16;
  static const double button = 14;
  static const double title = 16;
  static const double subtitle = 16;
  static const double interaction = 18;
  static const double header = 32;
  static const double header2 = 24;
}

class TextView extends StatelessWidget {
  final String? text;
  final Color? color, bgColor;
  final TextStyle? textType;
  final double? size, letterSpacing, height, boxHeight;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;

  const TextView(
    this.text, {
    Key? key,
    this.color,
    this.size,
    this.fontWeight,
    this.textType,
    this.letterSpacing,
    this.height,
    this.textAlign,
    this.boxHeight,
    this.bgColor,
    this.decoration,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      height: boxHeight,
      child: DefaultTextStyle(
        style: textType ?? TextType.regular,
        child: Text(
          '$text',
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: size,
            color: color ?? Colors.white,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            height: height,
            decoration: decoration,
          ),
        ),
      ),
    );
  }
}
