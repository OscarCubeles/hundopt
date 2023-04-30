import 'package:flutter/material.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                StringConstants.loginLabel,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.left,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height * 0.05)),
              Obx(() {
                return CustomTextField(
                    isPassword: false,
                    labelText: StringConstants.emailLabel,
                    errorText: controller.lEmailErrText.value ?? "",
                    onChanged: controller.lEmailChanged, initialValue: '',);
              }),
              Obx(() {
                return CustomTextField(
                    isPassword: true,
                    labelText: StringConstants.passwordLabel,
                    errorText: controller.lPwdErrText.value ?? "",
                    onChanged: controller.lPwdChanged, initialValue: '',);
              }),
              Padding(padding: EdgeInsets.all(5)),
              ClickableText(
                  uText: StringConstants.recuperateLabel,
                  text: StringConstants.forgotPwdText,
                  onPressed: () => controller.navigateToForgotPwd()),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height * 0.23)),
              AppPrimaryButton(
                  text: StringConstants.loginLabel,
                  onPressed: () => controller.login()),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
              ClickableText(
                  uText: StringConstants.createAccountLabel,
                  text: StringConstants.noAccountText,
                  onPressed: () => controller.navigateToRegister())
            ],
          ),
        ));
  }

  Widget _buildForms(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ),
      ),
    );
  }
}
