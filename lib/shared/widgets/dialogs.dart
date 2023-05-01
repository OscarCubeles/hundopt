import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../constants/string_constants.dart';
import 'buttons.dart';
import 'clickable_text.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog(
      {super.key,
      required this.text,
      required this.buttonText,
      required this.underlinedText,
      required this.buttonColor,
      required this.title,
      required this.onPressed,
      required this.onClose});

  final String title;
  final String text;
  final String buttonText;
  final String underlinedText;
  final Color buttonColor;
  final VoidCallback onPressed;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(backgroundColor: ColorConstants.background, children: [
      Container(
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
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.start,
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      text,
                      //StringConstants.resetPwdMsg,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    AppButton(
                      text: buttonText,
                      onPressed: onPressed,
                      buttonColor: buttonColor,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: ClickableText(
                            uText: underlinedText,
                            text: "",
                            onPressed: onPressed))
                    // TODO: MAke widget of this dialog, change the alignment of the clickabletext and change this onpressed
                  ]),

              //margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            ),
          ],
        ),
      )
    ]);
  }
}
