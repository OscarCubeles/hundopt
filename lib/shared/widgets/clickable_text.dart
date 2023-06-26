import 'package:flutter/material.dart';

/// The [ClickableText] class creates custom widget that displays clickable text.
class ClickableText extends StatelessWidget {
  /// The underlined text.
  final String uText;

  /// The non-underlined text.
  final String text;

  /// The callback function when the text is pressed.
  final VoidCallback onPressed;

  /// Constructs a new instance of the [ClickableText] class with the specified parameters.
  ///
  /// The [uText], [text], and [onPressed] parameters must not be null.
  const ClickableText({
    super.key,
    required this.uText,
    required this.text,
    required this.onPressed,
  });

  /// Builds the `ClickableText` widget.
  ///
  /// This method returns a `GestureDetector` widget that contains a `RichText` widget.
  /// The `RichText` widget displays the `text` parameter and the `uText` parameter with different styles.
  /// The `GestureDetector` widget uses the `onPressed` parameter to determine the callback function when the text is pressed.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "$text ",
          style: Theme.of(context).textTheme.bodyMedium,
          children: <TextSpan>[
            TextSpan(
              text: uText,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
