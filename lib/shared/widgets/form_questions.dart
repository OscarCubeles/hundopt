import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/constants/colors.dart';
import 'package:hundopt/shared/widgets/text_field.dart';
import '../../models/personality_form_question.dart';
import '../../modules/personality_from/form_controller.dart';
import '../constants/string_constants.dart';
import '../constants/styles.dart';

/// The [FormSelectorQuestion] class creates custom widget that displays a selector question in a form.
class FormSelectorQuestion extends StatelessWidget {
  /// The form controller.
  final FormController controller;

  /// The personality form question.
  final PersonalityFormQuestion formQuestion;

  /// Constructs a new instance of the [FormSelectorQuestion] class with the specified parameters.
  ///
  /// The [controller] and [formQuestion] parameters must not be null.
  const FormSelectorQuestion({
    super.key,
    required this.controller,
    required this.formQuestion,
  });

  /// Builds the `FormSelectorQuestion` widget.
  ///
  /// This method returns a `Column` widget that contains the question title, question text, and a list of radio buttons.
  /// The `Obx` widget is used to update the widget when the selected option changes.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              formQuestion.title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Text(formQuestion.text,
              style: Styles.bodySmall, textAlign: TextAlign.justify),
          const Padding(padding: EdgeInsets.all(10)),
          Column(
            children: List.generate(
              formQuestion.options.length,
              (index) => RadioListTile(
                title: Text(formQuestion.options[index],
                    style: Theme.of(context).textTheme.bodyMedium),
                value: index,
                toggleable: true,
                groupValue: controller.selectedOptionList[formQuestion.index],
                onChanged: (int? value) {
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

/// A custom widget that displays a written question in a form.
class FormWrittenQuestion extends StatelessWidget {
  /// The form controller.
  final FormController controller;

  /// Constructs a new instance of the [FormWrittenQuestion] class with the specified parameters.
  ///
  /// The [controller] parameter must not be null.
  const FormWrittenQuestion({Key? key, required this.controller})
      : super(key: key);

  /// Builds the `FormWrittenQuestion` widget.
  ///
  /// This method returns a `Column` widget that contains the question title, question text, and a text field.
  /// The `Obx` widget is used to update the widget when the name text changes.
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(padding: EdgeInsets.all(10)),
        Text(
          StringConstants.helloText,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Padding(padding: EdgeInsets.all(10)),
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
