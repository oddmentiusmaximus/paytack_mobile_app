import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String btnTitle;
  final double tvSize;
  final bool? isEnabled;
  final FontWeight fontWeight;
  final Color? color;
  final double radius;
  final double height;
  final double width;
  final Color? tvColor;

  CustomButton(
      {this.onPress,
      this.btnTitle = "",
      this.fontWeight = FontWeight.normal,
      this.color = pPrimaryColor,
      this.radius = 4.0,
      this.height = 40.0,
      this.width = double.infinity,
      this.isEnabled,
      this.tvColor,
      this.tvSize = 12.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress!(),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            radius,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: pProgress,
              blurRadius: 1.0,
              offset: const Offset(0.0, 0.4),
            )
          ],
        ),
        child: TView(
          title: btnTitle,
          isMaxLines: true,
          size: tvSize,
          color: tvColor!,
        ),
      ),
    );
  }
}

class OutlineButtonCommon extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? btnTitle;
  final double? tvSize;
  final Color? textColor;
  final bool? isEnabled;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? btnColor;
  final double? radius;
  final double? height;
  final double horizontalPadding;
  final double verticalPadding;
  final String? icon;

  const OutlineButtonCommon(
      {Key? key,
      this.onPressed,
      this.btnTitle,
      this.tvSize,
      this.isEnabled,
      this.fontWeight,
      this.color,
      this.radius,
      this.height,
      this.btnColor,
      this.textColor,
      this.icon,
      this.horizontalPadding = 0.0,
      this.verticalPadding = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = OutlinedButton.styleFrom(
        shape: StadiumBorder(),
        side: BorderSide(width: 1.0, color: btnColor!),
        backgroundColor: Colors.white);
    return Container(
      child: OutlinedButton.icon(
        style: style,
        onPressed: onPressed,
        label: TView(
          title: btnTitle!,
          size: tvSize!,
          color: textColor!,
        ),
        icon: ImageIcon(
          AssetImage(icon!),
          size: 14.0,
          color: pTextColors,
        ),
      ),
    );
  }
}
