import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/constants/colors.dart';

import 'package:hundopt/shared/widgets/text_field.dart';

import '../../models/personality_form_question.dart';
import '../../modules/personality_from/form_controller.dart';
import '../constants/string_constants.dart';
import '../constants/styles.dart';

class FormSelectorQuestion extends StatelessWidget {
  final FormController controller;
  final PersonalityFormQuestion formQuestion;


  const FormSelectorQuestion(
      {super.key, required this.controller, required this.formQuestion});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              formQuestion.title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Text(formQuestion.text, style: Styles.bodySmall, textAlign: TextAlign.justify),
          Padding(padding: EdgeInsets.all(10)),
          Column(
            children: List.generate(
              formQuestion.options.length,
              (index) => RadioListTile(
                title: Text(formQuestion.options[index], style:Theme.of(context).textTheme.bodyMedium),
                value: index,
                toggleable: true,
                groupValue: controller.selectedOptionList[formQuestion.index],
                onChanged: (int? value) {
                  //controller.selectedOptionList[formQuestion.index] = index;
                  controller.onOptionSelected(value!, formQuestion.index);
                },
                activeColor: ColorConstants.appColor,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class FormWrittenQuestion extends StatelessWidget {
  const FormWrittenQuestion({Key? key, required this.controller})
      : super(key: key);
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
          style: Styles.bodySmall,
          textAlign: TextAlign.justify,
        ),
        Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02)),
        Obx(() {
          return CustomTextField(
            labelText: StringConstants.nameAndSurnameLabel,
            errorText: controller.nameErrorText.value ?? "",
            onChanged: controller.nameChanged,
            isPassword: false,
            initialValue: controller.isNameOk ? controller.nameText.value : "",
          );
        })
      ],
    );
  }

}
