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
      //    textButtonTheme: textButtonTheme()
    );
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
      headlineLarge: const TextStyle(
        fontSize: 50,
        fontFamily: "DM Sans",
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: const TextStyle(
          fontSize: 25,
          fontFamily: "DM Sans",
          fontWeight: FontWeight.bold,
          color: Colors.black),
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
      titleLarge: TextStyle(
          fontSize: 30,
          fontFamily: "DM Sans",
          fontWeight: FontWeight.bold,
          color: ColorConstants.black),
      titleMedium: TextStyle(
          fontSize: 28,
          fontFamily: "DM Sans",
          fontWeight: FontWeight.bold,
          color: ColorConstants.black),
      titleSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: ColorConstants.appColor,
          fontFamily: "DM Sans",
          decoration: TextDecoration.underline),
      bodyLarge: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
          fontFamily: "DM Sans"),
      bodyMedium: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontFamily: "DM Sans"),
      bodySmall: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontFamily: "DM Sans",
        overflow: TextOverflow.ellipsis,
      ),
      labelLarge: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: "DM Sans",
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: ColorConstants.chatTextGray,
        fontFamily: "DM Sans",
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: ColorConstants.chatTextGray,
        fontFamily: "DM Sans",
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: "DM Sans",
      ),
    );
  }
}
