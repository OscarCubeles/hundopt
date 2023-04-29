import 'package:flutter/material.dart';

class ColorConstants {
  static Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = hexToColor('#22DDA6');
  static Color secondaryDarkAppColor = Colors.white;
  static Color tipColor = hexToColor('#B6B6B6');
  static Color lightGray = Color(0xFFF6F6F6);
  static Color darkGray = Color(0xFF9F9F9F);
  static Color black = Color(0xFF000000);
  static Color white = Color(0xFFFFFFFF);
  static Color background = Color(0xFFEEEEE0);
  static Color appColor = Color(0xFF2C6A4A);
  static Color textFieldBg = Color(0xFFECECEC);
  static Color secondaryButtonOnPressed = Color(0x1F2C6A4A);
  static Color primaryButtonOnPressed = Color(0x1FEEEEE0);
  static Color appGrey = Color(0xFF7A7073);
  static Color formBarBackground = Color(0xFFD9D9D9);
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

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
  'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
