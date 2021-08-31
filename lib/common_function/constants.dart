import 'package:flutter/material.dart';

const pPrimaryColor = Color(0xFF2BC5B4);
const pBackgroundScreen = Color(0xFFFFFFFF);
const pProgress = Color(0xFF159A8C);
const pDisableColor = Color(0xFFAFAFAF);
const pTextColor = Color(0xFF41424B);
const pPhoneText = Color(0xFF222222);
const pTextColors = Color(0xFF41424B);
const pTextColor3 = Color(0xFF626262);
const pDisable = Color(0xFF424B54);
const pHomePageTextColor = Color(0xFF7C8D9D);
const pBorderGrey = Color(0xFFCDCDCD);
const pBottomNav = Color(0xFF939393);
const pSlider = Color(0xFFC4F2ED);
const pSlider1 = Color(0xFFF6D9CB);
const pError = Color(0xFFF32D2D);
const pIconColor = Color(0xFFE3E4F7);
const pBubbleColor = Color(0xFF939329);
/*Fonts*/
const latoFont = 'assets/fonts/Lato-Black.ttf';
const latoFontRegular = 'assets/fonts/Lato-Regular.ttf';

/*Widget*/
Widget pVerticalSpace({height: 10.0}) => SizedBox(height: height);

Widget pHorizontalSpace({width: 10.0}) => SizedBox(width: width);

Widget pDivider({color: Colors.white, thickness: 1.5, endIndent: 80.0}) =>
    Divider(color: color, thickness: thickness, endIndent: endIndent);

Widget pAssetIcon({String path: "", width: 35.0, height: 35.0}) =>
    Image.asset(path, width: width, height: height, fit: BoxFit.cover);
// Jio Text Style
TextStyle commonTextStyle({
  String type: "B1",
  Color color = pTextColor,
  FontWeight weight: FontWeight.normal,
}) {
  FontWeight fontWeight;
  if (weight == FontWeight.bold) {
    fontWeight = FontWeight.w600;
  } else if (weight == FontWeight.normal) {
    fontWeight = FontWeight.w300;
  } else {
    fontWeight = FontWeight.w500;
  }

  /// final style
  return TextStyle(
    color: color,
    fontSize: mobile_type_size[type],
    fontWeight: fontWeight,
    fontFamily: "Lato",
  );
}

/*Size*/
const mobile_type_size = {
  "D1": 50.0,
  "D2": 42.0,
  "h1": 36.0,
  "h2": 28.0,
  "h3": 24.0,
  "h4": 20.0,
  "h5": 16.0,
  "h6": 14.0,
  "B1": 16.0,
  "B2": 14.0,
  "CAPTION": 12.0,
  "OVERLINE": 10.0,
  "18": 18.0,
  "8": 8.0,
};

const secure_access_key = 'access_token';

const List<Map<String, dynamic>> list = [
  {"title": "one", "id": "1", "lat": 23.7985053, "lon": 90.3842538},
  {"title": "two", "id": "2", "lat": 23.802236, "lon": 90.3700},
  {"title": "three", "id": "3", "lat": 23.8061939, "lon": 90.3771193},
  {"title": "three", "id": "4", "lat": 28.8061939, "lon": 90.3772193},
  {"title": "three", "id": "5", "lat": 27.8061939, "lon": 90.3773193},
  {"title": "three", "id": "6", "lat": 29.8061939, "lon": 90.3774193},
];
