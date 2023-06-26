import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';

/// The [ChatBody] class creates custom chat body widget for the app.
class ChatBody extends StatelessWidget {
  /// Whether the message is the user's own message.
  final bool isOwnMessage;

  /// The hour of the message.
  final String hour;

  /// The text of the message.
  final String text;

  /// Constructs a new instance of the [ChatBody] class with the specified parameters.
  ///
  /// The [isOwnMessage], [hour], and [text] parameters must not be null.
  const ChatBody({
    super.key,
    required this.isOwnMessage,
    required this.hour,
    required this.text,
  });

  /// Builds the `ChatBody` widget.
  ///
  /// This method returns a `Padding` widget that contains a `Column` widget.
  /// The `Column` widget contains a `Container` widget that displays the message text and a `Text` widget that displays the message hour.
  /// The `Container` widget uses the `isOwnMessage` parameter to determine the background color of the message.
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return isOwnMessage ? rcvMessageWidget(width) : ownMessageWidget(width);
  }

  /// Builds the received message widget.
  ///
  /// This method returns a `Padding` widget that contains an `Align` widget.
  /// The `Align` widget contains a `Column` widget that displays the message text and a `Text` widget that displays the message hour.
  /// The `Container` widget uses the `isOwnMessage` parameter to determine the background color of the message.
  Widget rcvMessageWidget(double width) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.8,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Text(
                text,
                style: Styles.bodySmall,
              ),
            ),
            SizedBox(height: 8),
            Text(
              hour,
              style: Styles.dateTimestamp,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the own message widget.
  ///
  /// This method returns a `Padding` widget that contains an `Align` widget.
  /// The `Align` widget contains a `Column` widget that displays the message text and a `Text` widget that displays the message hour.
  /// The `Container` widget uses the `isOwnMessage` parameter to determine the background color of the message.
  Widget ownMessageWidget(double width) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: width * 0.8,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorConstants.appChatMsg,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            Text(
              hour,
              style: Styles.dateTimestamp,
            ),
          ],
        ),
      ),
    );
  }
}
