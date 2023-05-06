import 'package:flutter/material.dart';

import 'constants.dart';

class Styles {
  static TextStyle labelActive = TextStyle(
    fontSize: 24,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.bold,
    color: ColorConstants.background,
  );

  static TextStyle labelInactive = TextStyle(
    fontSize: 24,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle locationLabelWhite = TextStyle(
    fontSize: 18,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.normal,
    color: ColorConstants.background,
  );

  static TextStyle locationLabelBlack = TextStyle(
    fontSize: 18,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  static TextStyle nameLabelBlack = TextStyle(
      fontSize: 25,
      fontFamily: "DM Sans",
      fontWeight: FontWeight.bold,
      color: Colors.black87
  );

  static TextStyle nameLabelWhite = TextStyle(
      fontSize: 25,
      fontFamily: "DM Sans",
      fontWeight: FontWeight.bold,
      color: ColorConstants.background);
}
