import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

class AuthController extends GetxController {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userController = TextEditingController();
  RxString username = RxString('');
  RxnString errorText = RxnString("");
  Rxn<Function()> submitFunc = Rxn<Function()>(null);



  @override
  void onInit() {
    debounce<String>(username, validations, time: const Duration(milliseconds: 500));
  }

  void validations(String val) async {
    errorText.value = ""; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      if (lengthOK(val) && await available(val)) {
        print('All validations passed, enable submit btn...');
        submitFunc.value = submitFunction();
        errorText.value = "";
      }
    }
  }

  bool lengthOK(String val, {int minLen = 5}) {
    if (val.length < minLen) {
      errorText.value = 'min. 5 chars';
      return false;
    }
    return true;
  }

  Future<bool> available(String val) async {
    print('Query availability of: $val');
    await Future.delayed(
        const Duration(seconds: 1),
            () => print('Available query returned')
    );

    if (val == "Sylvester") {
      errorText.value = 'Name Taken';
      return false;
    }
    return true;
  }

  void usernameChanged(String val) {
    username.value = val;
  }

  Future<bool> Function() submitFunction() {
    return () async {
      print('Make database call to create ${username.value} account');
      await Future.delayed(const Duration(seconds: 1), () => print('User account created'));
      return true;
    };
  }

  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
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
  }

  void resetPwd(){
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

  void login(){
    print("Login");
  }

  void register(){
    print("Register");
  }
}
