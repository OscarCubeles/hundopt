import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

class AuthController extends GetxController {
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
