import 'package:flutter/material.dart';
import 'package:hundopt/shared/shared.dart';

/// The [CustomTextField] class custom text field widget that can be used to read text inputs from a keyboard.
class CustomTextField extends StatelessWidget {
  /// The [labelText] parameter is the text to display as the label for the text field.
  final String labelText;

  /// The [errorText] parameter is the text to display as an error message if the input is invalid.
  final String errorText;

  /// The [isPassword] parameter is a boolean value that determines whether the text field should display the input as a password.
  final bool isPassword;

  /// The [initialValue] parameter is the initial value to display in the text field.
  final String initialValue;

  /// The [onChanged] parameter is a function to call when the input value changes.
  final ValueChanged<String>? onChanged;

  /// Constructs a new instance of the [CustomTextField] class with the specified parameters.
  ///
  /// The [labelText], [errorText], [onChanged], [isPassword], [initialValue] parameters must not be null.
  const CustomTextField(
      {super.key,
      required this.labelText,
      required this.errorText,
      required this.onChanged,
      required this.isPassword,
      required this.initialValue});

  /// Builds a [TextFormField] widget with the specified properties.
  ///
  /// The [context] parameter is the build context.
  /// The [initialValue] parameter is the initial value to display in the text field.
  /// The [isPassword] parameter is a boolean value that determines whether the text field should display the input as a password.
  /// The [onChanged] parameter is a function to call when the input value changes.
  /// The [labelText] parameter is the text to display as the label for the text field.
  /// The [errorText] parameter is the text to display as an error message if the input is invalid.
  ///
  /// Returns a [TextFormField] widget.
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: isPassword,
      style: Theme.of(context).textTheme.bodySmall,
      cursorColor: ColorConstants.appColor,
      onChanged: onChanged,
      decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          errorMaxLines: 3,
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.black),
          ),
          filled: true,
          errorStyle: const TextStyle(
            fontSize: 14,
          ),
          labelStyle: Theme.of(context).textTheme.bodySmall,
          fillColor: ColorConstants.textFieldBg,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: ColorConstants.appColor),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: ColorConstants.appColor),
          )),
    );
  }
}

/// The [EditProfileTextField] class custom text field widget that can be used to edit profile information.
class EditProfileTextField extends StatelessWidget {
  /// The [labelText] parameter is the text to display as the label for the text field.
  final String labelText;

  /// The [errorText] parameter is the text to display as an error message if the input is invalid.
  final String errorText;

  /// The [initialValue] parameter is the initial value to display in the text field.
  final String initialValue;

  /// The [onChanged] parameter is a function to call when the input value changes.
  final ValueChanged<String>? onChanged;

  /// Constructs a new instance of the [EditProfileTextField] class with the specified parameters.
  ///
  /// The [labelText], [errorText], [initialValue] parameters must not be null.
  const EditProfileTextField({
    super.key,
    required this.labelText,
    required this.errorText,
    required this.initialValue,
    this.onChanged,
  });

  /// Builds a [TextFormField] widget with the specified properties for editing profile information.
  ///
  /// The [context] parameter is the build context.
  /// The [initialValue] parameter is the initial value to display in the text field.
  /// The [onChanged] parameter is a function to call when the input value changes.
  /// The [labelText] parameter is the text to display as the label for the text field.
  /// The [errorText] parameter is the text to display as an error message if the input is invalid.
  ///
  /// Returns a [TextFormField] widget.
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodySmall,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConstants.textFieldBg,
        border: const UnderlineInputBorder(),
        labelStyle: Theme.of(context).textTheme.bodySmall,
        labelText: labelText,
        errorText: errorText,
        errorMaxLines: 3,
        errorStyle: const TextStyle(fontSize: 14),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
