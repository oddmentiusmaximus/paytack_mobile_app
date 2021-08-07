import 'package:flutter/material.dart';
import 'package:paytack/common_function/constants.dart';

class PayTackTheme {
  PayTackTheme._();

  static final ThemeData lightPayTackTheme = ThemeData(
      primaryColor: pPrimaryColor,
      backgroundColor: pBackgroundScreen,
      scaffoldBackgroundColor: pBackgroundScreen,
      fontFamily: "Lato",
      textTheme: TextTheme(
        headline1: TextStyle(color: Color(0xFFFFFFFF)),
        headline2: TextStyle(color: Color(0xFFFFFFFF)),
        headline3: TextStyle(color: Color(0xFFFFFFFF)),
        headline4: TextStyle(color: Color(0xFFFFFFFF)),
        headline5: TextStyle(color: Color(0xFFFFFFFF)),
        headline6: TextStyle(color: Color(0xFFFFFFFF)),
      ));

  static final ThemeData darkTheme = ThemeData(
      primaryColor: Colors.black,
      textTheme: TextTheme(
        headline1: TextStyle(color: Color(0xFF000000)),
        headline2: TextStyle(color: Color(0xFFFFFFFF)),
        headline3: TextStyle(color: Color(0xFFFFFFFF)),
        headline4: TextStyle(color: Color(0xFFFFFFFF)),
        headline5: TextStyle(color: Color(0xFFFFFFFF)),
        headline6: TextStyle(color: Color(0xFFFFFFFF)),
      ));
}
