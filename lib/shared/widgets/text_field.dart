import 'package:flutter/material.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/widgets/app_bar.dart';

import '../../routes/app_pages.dart';


class CustomTextField extends StatelessWidget{
  final String labelText;
  const CustomTextField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: ColorConstants.appColor,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        fillColor: ColorConstants.textFieldBg,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 3, color: ColorConstants.appColor),
        ),
      ),
    );
  }

}