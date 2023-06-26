import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';

/// The [AppPrimaryButton] class creates custom primary button widget for the app.
class AppPrimaryButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// A callback function for when the button is pressed.
  final VoidCallback onPressed;

  /// Constructs a new instance of the [AppPrimaryButton] class with the specified parameters.
  ///
  /// The [text] and [onPressed] parameters must not be null.
  const AppPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  /// Builds the `AppPrimaryButton` widget.
  ///
  /// This method returns a `SizedBox` widget that contains a `TextButton` widget.
  /// The `TextButton` widget displays the `text` parameter and uses the `onPressed` parameter as the callback function.
  /// The `ButtonStyle` is used to set the background color and overlay color of the button.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          overlayColor: MaterialStateColor.resolveWith(
            (states) => ColorConstants.primaryButtonOnPressed,
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: Theme.of(context).textTheme.displaySmall),
      ),
    );
  }
}

/// The [AppSecondaryButton] class creates custom secondary button widget for the app.
class AppSecondaryButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// A callback function for when the button is pressed.
  final VoidCallback onPressed;

  /// Constructs a new instance of the [AppSecondaryButton] class with the specified parameters.
  ///
  /// The [text] and [onPressed] parameters must not be null.
  const AppSecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  /// Builds the `AppSecondaryButton` widget.
  ///
  /// This method returns a `SizedBox` widget that contains a `TextButton` widget.
  /// The `TextButton` widget displays the `text` parameter and uses the `onPressed` parameter as the callback function.
  /// The `ButtonStyle` is used to set the side color and overlay color of the button.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: MaterialStateProperty.all(
              BorderSide(width: 3.0, color: Theme.of(context).primaryColor)),
          overlayColor: MaterialStateColor.resolveWith(
            (states) => ColorConstants.secondaryButtonOnPressed,
          ),
        ),
        child: Text(text, style: Theme.of(context).textTheme.displayMedium),
      ),
    );
  }
}

/// The [ButtonPadding] class creates a custom padding widget for the app buttons.
class ButtonPadding extends StatelessWidget {
  /// Constructs a new instance of the [ButtonPadding] class.
  const ButtonPadding({super.key});

  /// Builds the `ButtonPadding` widget.
  ///
  /// This method returns a `Padding` widget with a top padding of 20.
  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0));
  }
}

/// The [AppButton] class creates custom button widget for the app.
class AppButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// A callback function for when the button is pressed.
  final VoidCallback onPressed;

  /// The background color of the button.
  final Color buttonColor;

  /// Constructs a new instance of the [AppButton] class with the specified parameters.
  ///
  /// The [text], [onPressed], and [buttonColor] parameters must not be null.
  const AppButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.buttonColor})
      : super(key: key);

  /// Builds the `AppButton` widget.
  ///
  /// This method returns a `SizedBox` widget that contains a `TextButton` widget.
  /// The `TextButton` widget displays the `text` parameter and uses the `onPressed` parameter as the callback function.
  /// The `ButtonStyle` is used to set the background color and overlay color of the button.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          overlayColor: MaterialStateColor.resolveWith(
            (states) => buttonColor.withOpacity(0.5),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: Styles.displaySmall),
      ),
    );
  }
}
