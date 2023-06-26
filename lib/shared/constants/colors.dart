import 'package:flutter/material.dart';

/// The [ColorConstants] class defines a set of color constants for use in the app.
class ColorConstants {
  /// The background color for light mode.
  static Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');

  /// The background color for dark mode.
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');

  /// The secondary color for the app.
  static Color secondaryAppColor = hexToColor('#22DDA6');

  /// The secondary color for dark mode.
  static Color secondaryDarkAppColor = Colors.white;

  /// The color to use for tips and hints.
  static Color tipColor = hexToColor('#B6B6B6');

  /// A light gray color.
  static Color lightGray = const Color(0xFFF6F6F6);

  /// A dark gray color.
  static Color darkGray = const Color(0xFF9F9F9F);

  /// The color black.
  static Color black = const Color(0xFF000000);

  /// The color white.
  static Color white = const Color(0xFFFFFFFF);

  /// The background color for the app.
  static Color background = const Color(0xFFEEEEE0);

  /// The primary color for the app.
  static Color appColor = const Color(0xFF2C6A4A);

  /// A transparent version of the primary color for the app.
  static Color transparentAppColor = const Color(0x9F2C6A4A);

  /// The background color for text fields.
  static Color textFieldBg = const Color(0xFFECECEC);

  /// The color to use for secondary buttons when pressed.
  static Color secondaryButtonOnPressed = const Color(0x1F2C6A4A);

  /// The color to use for primary buttons when pressed.
  static Color primaryButtonOnPressed = const Color(0x1FEEEEE0);

  /// A gray color to use for the app.
  static Color appGrey = const Color(0xFF7A7073);

  /// The background color for the form bar.
  static Color formBarBackground = const Color(0xFFD9D9D9);

  /// The color to use for chat text.
  static Color chatTextGray = const Color(0xFF8A91A8);

  /// The color to use for warning messages.
  static Color warningRed = const Color(0xFFE53434);

  /// A transparent version of the color white.
  static Color transparentWhite = const Color(0x93FFFFFF);

  /// The color to use for chat messages in the app.
  static Color appChatMsg = const Color(0x8F2C6A4A);

  /// The color to use for chat timestamps.
  static Color chatTimestamp = const Color(0x088A91A8);

  /// An invisible color.
  static Color invisible = const Color(0x00E53434);

  /// The material color for the app.
  static const MaterialColor appMaterialColor = MaterialColor(
    0xFFE57373,
    <int, Color>{
      50: Color(0x0F2C6A4A),
      100: Color(0x1F2C6A4A),
      200: Color(0x2F2C6A4A),
      300: Color(0x3F2C6A4A),
      400: Color(0x4F2C6A4A),
      500: Color(0x5F2C6A4A),
      600: Color(0x6F2C6A4A),
      700: Color(0x7F2C6A4A),
      800: Color(0x8F2C6A4A),
      900: Color(0xFF2C6A4A),
    },
  );
}

/// Converts a hex color string to a [Color] object.
///
/// The [hex] parameter must be in the format '#rrggbb' or '#rrggbbaa'.
///
/// Returns a [Color] object.
Color hexToColor(String hex) {
  assert(
    RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
    'hex color must be #rrggbb or #rrggbbaa',
  );

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
