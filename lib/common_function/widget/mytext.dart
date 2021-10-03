import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paytack/common_function/constants.dart';

class TView extends StatelessWidget {
  final String title;
  final double size;
  final double? letterSpacing;
  final Color color;
  final TextAlign align;
  final FontWeight weight;
  final bool isOverflow;
  final bool isMaxLines;
  final TextDecoration? textDecoration;

  TView({
    Key? key,
    this.title = "",
    this.size = 12.0,
    this.isOverflow = false,
    this.color = pPrimaryColor,
    this.weight = FontWeight.normal,
    this.isMaxLines = false,
    this.textDecoration,
    this.align = TextAlign.center,
    this.letterSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: isOverflow ? TextOverflow.ellipsis : null,
      textScaleFactor: 1.0,
      textAlign: align,
      maxLines: isMaxLines ? null : 3,
      style: GoogleFonts.lato(
        letterSpacing: letterSpacing,
        color: color,
        fontSize: size,
        fontWeight: weight,
        decoration: textDecoration ?? TextDecoration.none,
      ),
    );
  }
}
