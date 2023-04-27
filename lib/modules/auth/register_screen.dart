import 'package:flutter/material.dart';
import 'package:hundopt/modules/auth/auth.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/shared.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: ColorConstants.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringConstants.crearCuenta,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.05)),
                  Obx(() => CustomTextField(
                        isPassword: false,
                        labelText: StringConstants.nombreUsuario,
                        errorText: controller.rUsernameErrText.value ?? "",
                        onChanged: controller.rUsernameChanged,
                      )),
                  Obx(
                    () => CustomTextField(
                        isPassword: false,
                        labelText: StringConstants.email,
                        errorText: controller.rEmailErrText.value ?? "",
                        onChanged: controller.rEmailChanged),
                  ),
                  Obx(() => CustomTextField(
                      isPassword: true,
                      labelText: StringConstants.password,
                      errorText: controller.rPwdErrText.value ?? "",
                      onChanged: controller.rPwdChanged)),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.215)),
                  AppPrimaryButton(
                      text: StringConstants.crearCuenta,
                      onPressed: () => controller.register()),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
                  ClickableText(
                      uText: StringConstants.iniciarSession,
                      text: StringConstants.yesAccount,
                      onPressed: () => controller.navigateToLogin()),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
