import 'package:flutter/material.dart';

/// The [SizeConfig] class that provides utility methods for sizing and scaling widgets.
class SizeConfig {
  /// Private constructor for the `SizeConfig` class.
  /// This constructor is used to create a new instance of the `SizeConfig` class.
  SizeConfig._();

  /// Static variable that holds a single instance of the `SizeConfig` class.
  static SizeConfig _instance = SizeConfig._();

  /// Factory constructor that returns the single instance of the `SizeConfig` class.
  /// This constructor is used to implement the Singleton pattern, where only one instance of a class is created and shared across the entire application.
  factory SizeConfig() => _instance;

  /// The `MediaQueryData` object obtained from the `BuildContext`.
  late MediaQueryData _mediaQueryData;

  /// The width of the screen in pixels.
  late double screenWidth;

  /// The height of the screen in pixels.
  late double screenHeight;

  /// The horizontal size of a block in pixels.
  late double blockSizeHorizontal;

  /// The vertical size of a block in pixels.
  late double blockSizeVertical;

  /// The horizontal size of the safe area in pixels.
  late double _safeAreaHorizontal;

  /// The vertical size of the safe area in pixels.
  late double _safeAreaVertical;

  /// The horizontal size of a safe block in pixels.
  late double safeBlockHorizontal;

  /// The vertical size of a safe block in pixels.
  late double safeBlockVertical;

  /// The width of the profile drawer.
  double? profileDrawerWidth;

  /// The reference height used for scaling.
  late double refHeight;

  /// The reference width used for scaling.
  late double refWidth;

  /// Initializes the `SizeConfig` object with the given [context].
  ///
  /// The [screenWidth] and [screenHeight] are obtained from the `MediaQueryData` object of the given [context].
  /// The [refHeight] and [refWidth] are set to default values.
  /// The [blockSizeHorizontal] and [blockSizeVertical] are calculated based on the screen size.
  /// The [safeBlockHorizontal] and [safeBlockVertical] are calculated based on the screen size and safe area.
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    refHeight = 1450;
    refWidth = 670;
    if (screenHeight < 1200) {
      blockSizeHorizontal = screenWidth / 100;
      blockSizeVertical = screenHeight / 100;
      _safeAreaHorizontal =
          _mediaQueryData.padding.left + _mediaQueryData.padding.right;
      _safeAreaVertical =
          _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
      safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
      safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    } else {
      blockSizeHorizontal = screenWidth / 120;
      blockSizeVertical = screenHeight / 120;
      _safeAreaHorizontal =
          _mediaQueryData.padding.left + _mediaQueryData.padding.right;
      _safeAreaVertical =
          _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
      safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 120;
      safeBlockVertical = (screenHeight - _safeAreaVertical) / 120;
    }
  }

  /// Returns the width ratio of the given [val].
  ///
  /// The [val] parameter is divided by the [refWidth] and multiplied by 100 to get the percentage of the reference width.
  /// The result is then multiplied by the [blockSizeHorizontal] to get the width in pixels.
  double getWidthRatio(double val) {
    double res = (val / refWidth) * 100;
    double temp = res * blockSizeHorizontal;
    return temp;
  }

  /// Returns the height ratio of the given [val].
  ///
  /// The [val] parameter is divided by the [refHeight] and multiplied by 100 to get the percentage of the reference height.
  /// The result is then multiplied by the [blockSizeVertical] to get the height in pixels.
  double getHeightRatio(double val) {
    double res = (val / refHeight) * 100;
    double temp = res * blockSizeVertical;
    return temp;
  }

  /// Returns the font ratio of the given [val].
  ///
  /// The [val] parameter is divided by the [refWidth] and multiplied by 100 to get the percentage of the reference width.
  /// The result is then multiplied by the [safeBlockHorizontal]
  /// or [safeBlockVertical] depending on the screen orientation to get the font size in pixels.
  double getFontRatio(double val) {
    double res = (val / refWidth) * 100;
    double temp = 0.0;
    if (screenWidth < screenHeight) {
      temp = res * safeBlockHorizontal;
    } else {
      temp = res * safeBlockVertical;
    }
    return temp;
  }
}

/// Extension methods for `num` to convert to width, height, and font sizes.
extension SizeUtils on num {
  double get toWidth => SizeConfig().getWidthRatio(this.toDouble());

  double get toHeight => SizeConfig().getHeightRatio(this.toDouble());

  double get toFont => SizeConfig().getFontRatio(this.toDouble());
}
