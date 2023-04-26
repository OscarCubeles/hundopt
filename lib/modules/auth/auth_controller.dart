import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

// TODO: source of the form code: https://stackoverflow.com/questions/64544571/flutter-getx-forms-validation

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userController = TextEditingController();
  RxString username = RxString('');
  RxnString fEmailErrText = RxnString(null);

  Rxn<Function()> submitFunc = Rxn<Function()>(() => {});

  @override
  void onInit() {
    super.onInit();
    debounce<String>(username, fEmailValidations,
        time: const Duration(milliseconds: 500));
  }

  void fEmailValidations(String val) async {
    fEmailErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (isValidEmail(val) /*&& await available(val)*/) {
        submitFunc.value = () {
          showResetPwdDialog();
        };
        fEmailErrText.value = "";
      }
    }
  }

  bool isValidEmail(String val) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val)) {
      fEmailErrText.value = 'Error. Formato de email no válido.';
      return false;
    }
    return true;
  }

  bool lengthOK(String val, {int minLen = 5}) {
    if (val.length < minLen) {
      fEmailErrText.value = 'min. 5 chars';
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

  void usernameChanged(String val) {
    username.value = val;
  }

  Function() sendForgotPwdEmail() {
    return () {};
  }

  Future<bool> Function() submitFunction() {
    return () async {
      print('Make database call to create ${username.value} account');
      await Future.delayed(
          const Duration(seconds: 1), () => print('User account created'));
      return true;
    };
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void sendResetPwdEmail() {
    // TODO: Make API Call to reset password
    print("Email sent");
  }

  void showResetPwdDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.correoEnviado,
            text: StringConstants.resetPwdMsg,
            buttonText: StringConstants.continuar,
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

  void login() {
    print("Login");
  }

  void register() {
    print("Register");
  }
}
