import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/personality_form_question.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';
import '../../shared/widgets/widgets.dart';

class FormController extends GetxController {
  RxnString nameErrorText = RxnString("");
  RxString nameText = RxString("");
  List<int> selectedOptionList = [0,0,0,0,0,0,0].obs;

  var selectedOption = 0.obs;
  RxDouble progress = 0.0.obs;
  var currentQuestion = 0.obs;
  late List<StatelessWidget> questionWidgets;
  late List<Function> widgetFunctions;
  late bool isNameOk;

  @override
  void onInit() {
    super.onInit();
    debounce<String>(nameText, nameTextValidations,
        time: const Duration(milliseconds: 500));
    questionWidgets = [
      FormWrittenQuestion(controller: this),
      ...buildFormSelectorQuestions(),
    ];
    widgetFunctions = [
      processFullName,
      nextQuestion,
      nextQuestion,
      nextQuestion,
      nextQuestion,
      nextQuestion,
      nextQuestion,
      nextQuestion,
    ];
    isNameOk = false;
  }

  List<FormSelectorQuestion> buildFormSelectorQuestions() {
    return StringConstants().formQuestions.map((question) {
      return FormSelectorQuestion(
        controller: this,
        formQuestion: question,
      );
    }).toList();
  }

  void onOptionSelected(int index, int currQuestion) {
    selectedOptionList[currQuestion] = index;
    print(selectedOptionList);
  }

  void nameTextValidations(String val) async {
    nameErrorText.value = null;
    if (val.isNotEmpty) {
      if (isValidName(val, nameErrorText)) {
        // reset validation errors to nothing
        nameErrorText.value = "";
        isNameOk = true;
      }
    }
  }

  bool isValidName(String val, RxnString errText) {
    if (!RegExp(r'^[a-zA-ZÀ-ÖØ-öø-ÿÇçÑñ]+(\s[a-zA-ZÀ-ÖØ-öø-ÿÇçÑñ]+)+$')
        .hasMatch(val)) {
      errText.value = 'Error. Escribe un nombre y apellido válido';
      isNameOk = false;
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
  }

  void nextQuestion() {
    if (currentQuestion.value < questionWidgets.length - 1) {
      currentQuestion.value++;
      //selectedOption[currentQuestion.value] = selectedOption2.value;

    }
    progress.value = (currentQuestion.value) / (questionWidgets.length);
  }

  void showExitDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleFormExitText,
            text: StringConstants.bodyFormExitText,
            buttonText: StringConstants.exitFormLabel,
            underlinedText: "",
            buttonColor: ColorConstants.appColor,
            onPressed: () => navigateToHome(),
            onClose: () => Get.back(),
          );
        });
  }

  void navigateToHome() {
    Get.toNamed(Routes.HOME, arguments: this);
  }

  void processFullName() {
    if (isNameOk) {
      // TODO: Store the contents someohw
      nextQuestion();
      return;
    }
    nameErrorText.value = "Error. Escribe un nombre y apellido válido";
  }

  void continuePressed() {
    widgetFunctions[currentQuestion.value]();
  }

  void previousQuestion() {
    if (currentQuestion.value == 0) {
      showExitDialog();
      return;
    }
    if (currentQuestion.value > 0) {
      currentQuestion.value--;
    }
    progress.value = (currentQuestion.value) / (questionWidgets.length - 1);
  }
}
