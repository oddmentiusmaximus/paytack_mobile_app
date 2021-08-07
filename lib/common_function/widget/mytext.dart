import 'package:flutter/material.dart';
import 'package:paytack/common_function/constants.dart';

class TView extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  final TextAlign align;
  final FontWeight weight;
  final bool isOverflow;
  final bool isMaxLines;
  final TextDecoration? textDecoration;

  TView({
    Key? key,
    this.title="",
    this.size = 12.0,
    this.isOverflow = false,
    this.color = pPrimaryColor,
    this.weight = FontWeight.normal,
    this.isMaxLines = false,
    this.textDecoration,
    this.align = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: isOverflow ? TextOverflow.ellipsis : null,
      textScaleFactor: 1.0,
      textAlign: align,
      maxLines: isMaxLines ? null : 3,
      style: TextStyle(
        color: color,
        fontFamily: latoFontRegular,
        fontSize: size,
        fontWeight: weight,
        decoration: textDecoration ?? TextDecoration.none,
      ),
    );
  }
}
