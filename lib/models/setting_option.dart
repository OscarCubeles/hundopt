import 'package:flutter/cupertino.dart';

/// The [SettingOption] class representing a setting option with text, an icon, and an action to perform when pressed.
class SettingOption {
  /// The text to display for the setting option.
  final String text;

  /// The icon to display for the setting option.
  final IconData iconSource;

  /// The action to perform when the setting option is pressed.
  final VoidCallback onPressed;

  /// Constructs a new instance of the [SettingOption] class with the specified parameters.
  ///
  /// The [onPressed], [text], and [iconSource] parameters must not be null.
  SettingOption({
    required this.onPressed,
    required this.text,
    required this.iconSource,
  });
}
