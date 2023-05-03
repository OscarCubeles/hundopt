import 'package:flutter/material.dart';
import 'package:hundopt/shared/shared.dart';



class CustomTextField extends StatelessWidget{
  final String labelText;
  final String errorText;
  final bool isPassword;
  final String initialValue;
  final ValueChanged<String>? onChanged;
  const CustomTextField({super.key, required this.labelText,  required this.errorText, required this.onChanged, required this.isPassword, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: isPassword,
      style: Theme.of(context).textTheme.bodySmall,
      cursorColor: ColorConstants.appColor,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.black),
        ),
        filled: true,
        errorStyle: TextStyle(fontSize: 14),
        labelStyle: Theme.of(context).textTheme.bodySmall,
        fillColor: ColorConstants.textFieldBg,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 3, color: ColorConstants.appColor),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 3, color: ColorConstants.appColor),
        )
      ),
    );
  }

}

class EditProfileTextField extends StatelessWidget{
  final String labelText;
  final String errorText;
  final String initialValue;
  final ValueChanged<String>? onChanged;
  const EditProfileTextField({super.key, required this.labelText, required this.errorText, required this.initialValue, this.onChanged});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodySmall,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConstants.textFieldBg,
        border: UnderlineInputBorder(),
        labelText: labelText,
        errorText: errorText,
        errorStyle: Theme.of(context).textTheme.bodySmall,
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),

    );
  }


}