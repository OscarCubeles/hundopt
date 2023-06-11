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
      color: Colors.black87);

  static TextStyle nameLabelWhite = TextStyle(
      fontSize: 25,
      fontFamily: "DM Sans",
      fontWeight: FontWeight.bold,
      color: ColorConstants.background);

  static TextStyle bodyDescription = TextStyle(
    fontSize: 16.0,
    fontFamily: "DM Sans",
    color: Colors.grey,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: "DM Sans",
  );

  static TextStyle displaySmall = TextStyle(
    fontSize: 22,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.bold,
    color: ColorConstants.background,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle timestampGray = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ColorConstants.chatTextGray,
    fontFamily: "DM Sans",
  );

  static TextStyle headlineMedium = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: "DM Sans",
  );

  static TextStyle gridTileText = const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: "DM Sans",
  );

  static TextStyle featureText = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: "DM Sans",
    overflow: TextOverflow.clip,
  );

  static TextStyle shelterHeadline = const TextStyle(
      fontSize: 25,
      fontFamily: "DM Sans",
      fontWeight: FontWeight.bold,
      color: Colors.black,
      overflow: TextOverflow.clip);

  static TextStyle dateTimestamp = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: ColorConstants.chatTextGray,
    fontFamily: "DM Sans",
  );

  static TextStyle chatTabText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: ColorConstants.chatTextGray,
    fontFamily: "DM Sans",
    overflow: TextOverflow.clip,
  );
}
