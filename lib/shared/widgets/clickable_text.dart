import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget{

  final String uText;
  final String text;
  final VoidCallback onPressed;

  const ClickableText({super.key, required this.uText, required this.text, required this.onPressed});

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