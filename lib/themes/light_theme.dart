import 'package:flutter/material.dart';
import 'package:hundopt/shared/constants/colors.dart';

class LightTheme {
  static ThemeData theme(){
    return ThemeData(
      primaryColor: ColorConstants.appColor,
      primarySwatch: ColorConstants.appMaterialColor,
      scaffoldBackgroundColor: ColorConstants.background,
      textTheme: lightTextTheme(),


    );
  }

  static TextTheme? lightTextTheme(){
    return const TextTheme(
      displayLarge: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "DM Sans"
      ),
      displayMedium: TextStyle(),
      displaySmall: TextStyle(),
      headlineSmall: TextStyle(),
      titleLarge: TextStyle(),
      titleMedium: TextStyle(),
      titleSmall: TextStyle(),
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      bodySmall: TextStyle(),
      labelLarge: TextStyle(),
      labelSmall: TextStyle(),
    );
  }

}