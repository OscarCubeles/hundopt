import 'package:flutter/material.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/widgets/app_bar.dart';

import '../../routes/app_pages.dart';


class CustomTextField extends StatelessWidget{
  final String labelText;
  final String errorText;
  final String onChanged;
  final TextEditingController controller;
  const CustomTextField({super.key, required this.labelText, required this.controller, required this.errorText, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ColorConstants.appColor,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.black),
        ),
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