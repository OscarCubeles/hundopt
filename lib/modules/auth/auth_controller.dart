import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

// TODO: source of the form code: https://stackoverflow.com/questions/64544571/flutter-getx-forms-validation

class AuthController extends GetxController {
  RxnString fEmailErrText = RxnString(null);
  RxnString rEmailErrText = RxnString(null);
  RxnString rUsernameErrText = RxnString("");
  RxnString rPwdErrText = RxnString(null);
  RxnString lEmailErrText = RxnString(null);
  RxnString lPwdErrText = RxnString(null);

  RxString fEmail = RxString('');
  RxString rEmail = RxString('');
  RxString rUsername = RxString('');
  RxString rPwd = RxString('');
  RxString lEmail = RxString('');
  RxString lPwd = RxString('');

  Rxn<Function()> submitFunc = Rxn<Function()>(() => {});

  @override
  void onInit() {
    super.onInit();
    debounce<String>(fEmail, fEmailValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(lEmail, lEmailValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(lPwd, lPwdValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(rEmail, rEmailValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(rUsername, rUsernameValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(rPwd, rPwdValidations,
        time: const Duration(milliseconds: 500));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void fEmailValidations(String val) async {
    fEmailErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (isValidEmail(val, fEmailErrText)) {
        submitFunc.value = () {
          showResetPwdDialog();
        };
        fEmailErrText.value = "";
      }
    }
  }

  void lEmailValidations(String val) async {
    lEmailErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty ) {
      if (isValidEmail(val, lEmailErrText)/*&& await available(val)*/) { //FUTURE TODO: Change available function to check if the email exists
        submitFunc.value = () {};
        lEmailErrText.value = "";
      }
    }
  }

  void lPwdValidations(String val) async {
    lPwdErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (lengthOK(val, lPwdErrText)) {
        submitFunc.value = () {};
        lPwdErrText.value = "";
      }
    }
  }

  void rEmailValidations(String val) async {
    rEmailErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (isValidEmail(val, rEmailErrText/*&& await available(val)*/)) { //FUTURE TODO: Change available function to check if the email exists)) {
        submitFunc.value = () {};
        rEmailErrText.value = "";
      }
    }
  }

  void rUsernameValidations(String val) async {
    rUsernameErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (lengthOK(val, rUsernameErrText/*&& await available(val)*/)) { //FUTURE TODO: Change available function to check if the username exists)) {
        submitFunc.value = () {};
        rUsernameErrText.value = "";
      }
    }
  }

  void rPwdValidations(String val) async {
    rPwdErrText.value = ""; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (isValidPassword(val, rPwdErrText) && lengthOK(val, rPwdErrText)) {
        submitFunc.value = () {};
        rPwdErrText.value = "";
      }
    }
  }

  bool isValidEmail(String val, RxnString errText) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val)) {
      errText.value = 'Formato de email no válido.';
      return false;
    }
    return true;
  }

  bool isValidPassword(String val, RxnString errText){
    if (!RegExp(
        r"^(?=.*?[0-9])(?=.*?[^\w\s]).{1,}$")
        .hasMatch(val)) {
      errText.value = 'Al menos un número y un carácter especial.';
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

  Future<bool> available(String val) async {
    print('Query availability of: $val');
    await Future.delayed(
        const Duration(seconds: 1), () => print('Available query returned'));
    if (val == "Sylvester") {
      fEmailErrText.value = 'Name Taken';
      return false;
    }
    return true;
  }

  void fEmailChanged(String val) {
    fEmail.value = val;
  }

  void lEmailChanged(String val) {
    lEmail.value = val;
  }

  void rEmailChanged(String val) {
    rEmail.value = val;
  }

  void rUsernameChanged(String val) {
    rUsername.value = val;
  }

  void lPwdChanged(String val) {
    lPwd.value = val;
  }

  void rPwdChanged(String val) {
    rPwd.value = val;
  }

  Function() sendForgotPwdEmail() {
    return () {};
  }

  Future<bool> Function() submitFunction() {
    return () async {
      print('Make database call to create ${fEmail.value} account');
      await Future.delayed(
          const Duration(seconds: 1), () => print('User account created'));
      return true;
    };
  }

  void sendResetPwdEmail() {
    // TODO: Make API Call to reset password
    print("Email sent");
  }

  void showResetPwdDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.sentEmailLabel,
            text: StringConstants.resetPwdText,
            buttonText: StringConstants.continueLabel,
            underlinedText: "",
            buttonColor: ColorConstants.appColor,
            onPressed: () => navigateToLogin(),
            onClose: () => Get.back(),
          );
        });
    sendResetPwdEmail();
  }

  void resetPwd() {
    showResetPwdDialog();
  }

  void navigateToLogin() {
    Get.toNamed(Routes.AUTH + Routes.LOGIN, arguments: this);
  }

  void navigateToRegister() {
    Get.toNamed(Routes.AUTH + Routes.REGISTER, arguments: this);
  }

  void navigateToForgotPwd() {
    Get.toNamed(Routes.AUTH + Routes.FORGOT_PASSWORD, arguments: this);
  }

  // TODO: Make API Call Checks
  void login() {
    Get.toNamed(Routes.HOME);
  }

  // TODO: Make API Checks
  void register() {
    print("Register");
    Get.toNamed(Routes.ONBOARDING);
  }
}
