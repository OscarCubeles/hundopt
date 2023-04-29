import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hundopt/shared/widgets/text_field.dart';

import '../../modules/personality_from/form_controller.dart';
import '../constants/string_constants.dart';

class FormSelectorQuestion extends StatelessWidget {
  final String text;

  const FormSelectorQuestion({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          TextField(
            onChanged: (value) => {},
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              onPressed: () => {},
              child: Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Next'),
            )
          ]),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView.builder(
                itemCount: 10, // number of items in the list
                itemBuilder: (context, index) {
                  // create a widget for each item in the list
                  return CheckboxListTile(
                    selected: true,
                    value: false,
                    onChanged: (bool? value) {},
                  );
                },
              ))
        ],
      ),
    );
  }
}

class FormWrittenQuestion extends StatelessWidget {
  const FormWrittenQuestion({Key? key, required this.controller}) : super(key: key);
  final FormController controller;



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(padding: EdgeInsets.all(10)),
        Text(
          StringConstants.helloText,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text(
          StringConstants.helloFormText,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.justify,
        ),
        Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02)),
    Obx((){ return CustomTextField(
          labelText: StringConstants.nameAndSurnameLabel,
          errorText: controller.nameErrorText.value  ?? "",
          onChanged: controller.nameChanged,
          isPassword: false,
        );})
      ],
    );
  }

  void lEmailChanged(String val) {
    print(val);
  }
}
