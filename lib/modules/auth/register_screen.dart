import 'package:flutter/material.dart';
import 'package:hundopt/modules/auth/auth.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              StringConstants.createAccountText,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.start,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, MediaQuery.of(context).size.height * 0.05)),
            Obx(() => CustomTextField(
                  isPassword: false,
                  labelText: StringConstants.usernameLabel,
                  errorText: controller.rUsernameErrText.value ?? "",
                  onChanged: controller.rUsernameChanged, initialValue: '',
                )),
            Obx(
              () => CustomTextField(
                  isPassword: false,
                  labelText: StringConstants.emailLabel,
                  errorText: controller.rEmailErrText.value ?? "",
                  onChanged: controller.rEmailChanged, initialValue: '',),
            ),
            Obx(() => CustomTextField(
                isPassword: true,
                labelText: StringConstants.passwordLabel,
                errorText: controller.rPwdErrText.value ?? "",
                onChanged: controller.rPwdChanged, initialValue: '',)),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, MediaQuery.of(context).size.height * 0.155)),
            AppPrimaryButton(
                text: StringConstants.createAccountLabel,
                onPressed: () => controller.register()),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
            ClickableText(
                uText: StringConstants.loginLabel,
                text: StringConstants.yesAccountText,
                onPressed: () => controller.navigateToLogin()),
          ],
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
