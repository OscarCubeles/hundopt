import 'package:flutter/cupertino.dart';

class SettingOption{
  final String text;
  final IconData iconSource;
  final VoidCallback onPressed;

  SettingOption({required this.onPressed, required this.text, required this.iconSource});

}