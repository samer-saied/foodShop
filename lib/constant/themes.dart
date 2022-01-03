import 'package:flutter/material.dart';

import 'colors.dart';

class ThemesStyle {
  ThemeData defaultThemeStyle = ThemeData(
    fontFamily: 'Cairo',
    primarySwatch: Colors.red,
    textTheme: const TextTheme(
      subtitle1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      subtitle2: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        // color: greyColor,
      ),
      headline1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: blackColor,
      ),
      headline2: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: blackColor,
      ),
      headline3: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: blackColor,
      ),
      headline4: TextStyle(
        fontSize: 16,
        color: blackColor,
      ),
      headline5: TextStyle(
        fontSize: 14,
        color: blackColor,
      ),
      headline6: TextStyle(
        fontSize: 12,
        color: blackColor,
      ),
    ),
  );
}
