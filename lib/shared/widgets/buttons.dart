import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

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
          ),),
        onPressed: onPressed,
        child: Text(text, style: Theme.of(context).textTheme.displaySmall),
      ),
    );
  }
}

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(width: 3.0, color: Theme.of(context).primaryColor)),
            overlayColor: MaterialStateColor.resolveWith(
                  (states) => ColorConstants.secondaryButtonOnPressed,
            ),
          ),

          child: Text(
            text,
            style: Theme.of(context).textTheme.displayMedium,
          )),
    );
  }
}

class ButtonPadding extends StatelessWidget {
  const ButtonPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0));
  }
}

class AppButton extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;

  const AppButton({super.key, required this.text, required this.onPressed, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(buttonColor),
          overlayColor: MaterialStateColor.resolveWith(
                (states) => buttonColor.withOpacity(0.5),
          ),),
        onPressed: onPressed,
        child: Text(text, style: Theme.of(context).textTheme.displaySmall),
      ),
    );
  }

}