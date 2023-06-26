import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/firebase_core.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';
import '../../shared/shared.dart';

/// The [FormController] class manages all data and actions of a form controller screen
class FormController extends GetxController {
  /// A list of the form question widgets.
  late List<StatelessWidget> questionWidgets;

  /// A list of the widget functions.
  late List<Function> widgetFunctions = [];

  /// A reactive selected option.
  var selectedOption = 0.obs;

  /// A reactive current question.
  var currentQuestion = 0.obs;

  /// A boolean indicating if the full name input is valid.
  late bool isNameOk;

  /// A reactive full name error text.
  RxnString nameErrorText = RxnString("");

  /// A reactive full name text.
  RxString nameText = RxString("");

  /// A list of the selected options for each form question.
  List<int> selectedOptionList = [0, 0, 0, 0, 0, 0, 0].obs;

  /// A reactive progress.
  RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    initFormFieldValidators();
    initFormQuestions();
    isNameOk = false;
  }

  /// Initializes the form questions and widget functions.
  void initFormQuestions() {
    questionWidgets = [
      FormWrittenQuestion(controller: this),
      ...buildFormSelectorQuestions()
    ];
    widgetFunctions = [
      processFullName,
      nextQuestion,
      nextQuestion,
      nextQuestion,
      nextQuestion,
      nextQuestion,
      nextQuestion,
      submitPersonalityForm
    ];
  }

  /// Initializes the form field validators to be validated each 500ms.
  void initFormFieldValidators() {
    debounce<String>(nameText, nameTextValidations,
        time: const Duration(milliseconds: 500));
  }

  /// Builds the form selector questions.
  List<FormSelectorQuestion> buildFormSelectorQuestions() {
    return StringConstants().formQuestions.map((question) {
      return FormSelectorQuestion(
        controller: this,
        formQuestion: question,
      );
    }).toList();
  }

  /// Handles the option selection for a form question.
  ///
  /// The [index] parameter is the index of the selected option.
  /// The [currQuestion] parameter is the index of the current question.
  void onOptionSelected(int index, int currQuestion) {
    selectedOptionList[currQuestion] = index;
  }

  /// Validates the full name input.
  ///
  /// The [val] parameter is the full name input.
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

  /// Checks if the full name input is valid.
  ///
  /// The [val] parameter is the full name input.
  /// The [errText] parameter is the full name error text.
  bool isValidName(String val, RxnString errText) {
    if (!RegExp(r'^[a-zA-ZÀ-ÖØ-öø-ÿÇçÑñ]+(\s[a-zA-ZÀ-ÖØ-öø-ÿÇçÑñ]+)+$')
        .hasMatch(val)) {
      errText.value = StringConstants.fullNameErrorLabel;
      isNameOk = false;
      return false;
    }
    return true;
  }

  /// Handles the full name input change.
  ///
  /// The [val] parameter is the new value of the full name input.
  void nameChanged(String val) {
    nameText.value = val;
  }

  /// Handles the next question button press.
  void nextQuestion() {
    if (!hasDogs()) currentQuestion.value++;
    if (currentQuestion.value < questionWidgets.length - 1) {
      currentQuestion.value++;
    }
    progress.value = (currentQuestion.value) / (questionWidgets.length);
  }

  /// Checks if the user has answered as if he/she has dogs.
  bool hasDogs() {
    return selectedOptionList[0] == 0;
  }

  /// Shows the exit personality form dialog.
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
            onTextPressed: () => Get.back(),
          );
        });
  }

  /// Shows the personality form finished dialog.
  void showFinishedDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleFormEndText,
            text: StringConstants.bodyFormEndText,
            buttonText: StringConstants.exploreLabel,
            underlinedText: "",
            buttonColor: ColorConstants.appColor,
            onPressed: () => navigateToHome(),
            onClose: () => Get.back(),
            onTextPressed: () => {},
          );
        });
  }

  /// Navigates to the Home screen.
  void navigateToHome() {
    Get.toNamed(Routes.HOME, arguments: 0);
  }

  /// Processes the full name input.
  void processFullName() {
    if (isNameOk) {
      nextQuestion();
      return;
    }
    nameErrorText.value = StringConstants.fullNameErrorLabel;
  }

  /// Handles the continue button press.
  void continuePressed() {
    widgetFunctions[currentQuestion.value]();
  }

  /// Submits the personality form.
  void submitPersonalityForm() async {
    final user = FirebaseAuth.instance.currentUser;
    progress.value = 1.0;
    final PersonalityForm personalityForm =
        PersonalityForm.fromList(selectedOptionList, nameText.value, user?.uid);
    await PersonalityFormRepository().uploadForm(personalityForm);
    showFinishedDialog();
  }

  /// Shows the previous question in screen of the personality form.
  void previousQuestion() {
    if (currentQuestion.value == 0) {
      showExitDialog();
      return;
    }
    if (!hasDogs()) currentQuestion.value--;
    if (currentQuestion.value > 0) {
      currentQuestion.value--;
    }
    progress.value = (currentQuestion.value) / (questionWidgets.length - 1);
  }
}
