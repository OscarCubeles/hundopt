import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/styles.dart';

class ChatBody extends StatelessWidget {
  const ChatBody(
      {super.key,
      required this.isOwnMessage,
      required this.hour,
      required this.text});

  final bool isOwnMessage;
  final String hour;
  final String text;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return isOwnMessage ? rcvMessageWidget(width) : ownMessageWidget(width);
  }

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
