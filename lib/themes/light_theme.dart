import 'package:flutter/material.dart';
import 'package:hundopt/shared/constants/colors.dart';

/// The [LightTheme] class provides a light theme configuration for the application.
///
/// This class defines the color scheme, typography, and visual properties
/// for the light theme used throughout the application.
class LightTheme {
  /// Returns the light theme [ThemeData].
  ///
  /// The light theme includes primary color, primary swatch, scaffold background color,
  /// text theme, card theme, font family, and unselected widget color.
  static ThemeData theme() {
    return ThemeData(
      primaryColor: ColorConstants.appColor,
      primarySwatch: ColorConstants.appMaterialColor,
      scaffoldBackgroundColor: ColorConstants.background,
      textTheme: lightTextTheme(),
      cardTheme: cardTheme(),
      fontFamily: "DM Sans",
      unselectedWidgetColor: Colors.black,
    );
  }

  /// Returns the customized [TextButtonThemeData] for the light theme.
  ///
  /// The text button theme includes a custom style for text buttons, such as a
  /// specific side border width and color.
  static TextButtonThemeData? textButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        side: BorderSide(width: 3.0, color: ColorConstants.appColor),
      ),
    );
  }

  /// Returns the customized [CardTheme] for the light theme.
  ///
  /// The card theme includes properties like the background color, margin,
  /// and clip behavior for cards used in the application.
  static CardTheme? cardTheme() {
    return CardTheme(
      color: ColorConstants.background,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }

  /// Returns the customized [TextTheme] for the light theme.
  ///
  /// The text theme defines the styling for various types of text in the application,
  /// such as headlines, body text, captions, etc. This method provides the customized
  /// text theme specifically designed for the light theme.
  ///
  /// If the light text theme is not available or not specified, this method returns `null`.
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
      headlineMedium: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: "DM Sans",
      ),
    );
  }
}
