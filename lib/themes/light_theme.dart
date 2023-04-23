import 'package:flutter/material.dart';
import 'package:hundopt/shared/constants/colors.dart';

class LightTheme {
  static ThemeData theme() {
    return ThemeData(
        primaryColor: ColorConstants.appColor,
        primarySwatch: ColorConstants.appMaterialColor,
        scaffoldBackgroundColor: ColorConstants.background,
        textTheme: lightTextTheme(),
        cardTheme: cardTheme(),
        fontFamily: "DM Sans",
        unselectedWidgetColor: Colors.black,
        textButtonTheme: textButtonTheme());
  }

  static TextButtonThemeData? textButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        side: BorderSide(width: 3.0, color: ColorConstants.appColor),
      ),
    );
  }

  static CardTheme? cardTheme() {
    return CardTheme(
      color: ColorConstants.background,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }

  static TextTheme? lightTextTheme() {
    return TextTheme(
      displayLarge: const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "DM Sans"),
      displayMedium: TextStyle(
          fontSize: 25,
          fontFamily: "DM Sans",
          fontWeight: FontWeight.bold,
          color: ColorConstants.appColor),
      displaySmall: TextStyle(
          fontSize: 25,
          fontFamily: "DM Sans",
          fontWeight: FontWeight.bold,
          color: ColorConstants.background),
      headlineSmall: TextStyle(),
      titleLarge: TextStyle(),
      titleMedium: TextStyle(),
      titleSmall: TextStyle(),
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontFamily: "DM Sans"),
      bodySmall: TextStyle(),
      labelLarge: TextStyle(),
      labelSmall: TextStyle(),
    );
  }
}
