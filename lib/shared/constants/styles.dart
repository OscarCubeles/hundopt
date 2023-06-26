import 'package:flutter/material.dart';
import 'constants.dart';

/// The [Styles] class that defines a set of text styles for use in the app.
class Styles {
  /// The text style for active labels.
  static TextStyle labelActive = TextStyle(
    fontSize: 24,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.bold,
    color: ColorConstants.background,
  );

  /// The text style for inactive labels.
  static TextStyle labelInactive = const TextStyle(
    fontSize: 24,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// The text style for location labels with a white background.
  static TextStyle locationLabelWhite = TextStyle(
    fontSize: 18,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.normal,
    color: ColorConstants.background,
  );

  /// The text style for location labels with a black background.
  static TextStyle locationLabelBlack = const TextStyle(
    fontSize: 18,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  /// The text style for black name labels.
  static TextStyle nameLabelBlack = const TextStyle(
      fontSize: 25,
      fontFamily: "DM Sans",
      fontWeight: FontWeight.bold,
      color: Colors.black87);

  /// The text style for white name labels.
  static TextStyle nameLabelWhite = TextStyle(
      fontSize: 25,
      fontFamily: "DM Sans",
      fontWeight: FontWeight.bold,
      color: ColorConstants.background);

  /// The text style for body descriptions.
  static TextStyle bodyDescription = const TextStyle(
    fontSize: 16.0,
    fontFamily: "DM Sans",
    color: Colors.grey,
  );

  /// The text style for small bodies of text.
  static TextStyle bodySmall = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: "DM Sans",
  );

  /// The text style for small displays of text.
  static TextStyle displaySmall = TextStyle(
    fontSize: 22,
    fontFamily: "DM Sans",
    fontWeight: FontWeight.bold,
    color: ColorConstants.background,
    overflow: TextOverflow.ellipsis,
  );

  /// The text style for gray timestamps.
  static TextStyle timestampGray = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ColorConstants.chatTextGray,
    fontFamily: "DM Sans",
  );

  /// The text style for medium headlines.
  static TextStyle headlineMedium = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: "DM Sans",
  );

  /// The text style for grid tile text.
  static TextStyle gridTileText = const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: "DM Sans",
  );

  /// The text style for feature text.
  static TextStyle featureText = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: "DM Sans",
    overflow: TextOverflow.clip,
  );

  /// The text style for shelter headlines.
  static TextStyle shelterHeadline = const TextStyle(
      fontSize: 25,
      fontFamily: "DM Sans",
      fontWeight: FontWeight.bold,
      color: Colors.black,
      overflow: TextOverflow.clip);

  /// The text style for date timestamps.
  static TextStyle dateTimestamp = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: ColorConstants.chatTextGray,
    fontFamily: "DM Sans",
  );

  /// The text style for chat tab text.
  static TextStyle chatTabText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: ColorConstants.chatTextGray,
    fontFamily: "DM Sans",
    overflow: TextOverflow.clip,
  );

  /// The text style for medium shelter headlines.
  static TextStyle headlineShelterMedium = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: "DM Sans",
    overflow: TextOverflow.ellipsis,
  );
}
