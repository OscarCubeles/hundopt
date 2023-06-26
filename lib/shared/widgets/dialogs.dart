import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';
import 'buttons.dart';
import 'clickable_text.dart';

/// The [NotificationDialog] class creates custom notification dialog widget for the app.
class NotificationDialog extends StatelessWidget {
  /// The title of the dialog.
  final String title;

  /// The text of the dialog.
  final String text;

  /// The text of the button.
  final String buttonText;

  /// The underlined text of the dialog.
  final String underlinedText;

  /// The color of the button.
  final Color buttonColor;

  /// The callback function when the button is pressed.
  final VoidCallback onPressed;

  /// The callback function when the dialog is closed.
  final VoidCallback onClose;

  /// The callback function when the underlined text is pressed.
  final VoidCallback onTextPressed;

  /// Constructs a new instance of the [NotificationDialog] class with the specified parameters.
  ///
  /// The [title], [text], [buttonText], [underlinedText], [buttonColor], [onPressed], [onClose], and [onTextPressed] parameters must not be null.
  const NotificationDialog({
    super.key,
    required this.title,
    required this.text,
    required this.buttonText,
    required this.underlinedText,
    required this.buttonColor,
    required this.onPressed,
    required this.onClose,
    required this.onTextPressed,
  });

  /// Builds the `NotificationDialog` widget.
  ///
  /// This method returns a `SimpleDialog` widget that contains a `Container` widget.
  /// The `Container` widget contains a `Column` widget that displays the dialog title, text, button, and underlined text.
  /// The `IconButton` widget is used to close the dialog.
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: ColorConstants.background,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: ColorConstants.appColor,
                  size: 24,
                ),
                onPressed: onClose,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.start,
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: Styles.bodySmall,
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    AppButton(
                      text: buttonText,
                      onPressed: onPressed,
                      buttonColor: buttonColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ClickableText(
                        uText: underlinedText,
                        text: "",
                        onPressed: onTextPressed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
