import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../shared/widgets/widgets.dart';

class FormController extends GetxController {
  RxnString nameErrorText = RxnString(null);
  RxString nameText = RxString('');

  RxDouble progress = 0.0.obs;
  var currentIndex = 0.obs;

  late List<StatelessWidget> questions;

  @override
  void onInit() {
    super.onInit();
    debounce<String>(nameText, nameTextValidations,
        time: const Duration(milliseconds: 500));
    questions = [
      FormWrittenQuestion(controller: this),
      FormSelectorQuestion(text: 'Question 2'),
      FormSelectorQuestion(text: 'Question 3'),
      FormSelectorQuestion(text: 'Question 4'),
      FormSelectorQuestion(text: 'Question 5'),
      FormSelectorQuestion(text: 'Question 6'),
      FormSelectorQuestion(text: 'Question 7')
    ];
  }

  void nameTextValidations(String val) async {
    nameErrorText.value = null;
    print("hola"); // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (isValidName(val, nameErrorText)) {
        nameErrorText.value = "";
      }
    }
  }

  bool isValidName(String val, RxnString errText) {
    if (!RegExp(r'^[a-zA-ZÀ-ÖØ-öø-ÿÇçÑñ]+(\s[a-zA-ZÀ-ÖØ-öø-ÿÇçÑñ]+)+$').hasMatch(val)) {
      errText.value = 'Error. Entra un nombre y apellido válido';
      return false;
    }
    return true;
  }

  bool lengthOK(String val, RxnString err, {int minLen = 8}) {
    if (val.length < minLen) {
      err.value = 'La longitud mínima es de 8 caracteres';
      return false;
    }
    return true;
  }

  void nameChanged(String val) {
    nameText.value = val;
    print(nameText);
  }

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
    }
    progress.value = (currentIndex.value + 1) / questions.length;
  }

  void previousQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
    progress.value = (currentIndex.value + 1) / questions.length;
  }
}
