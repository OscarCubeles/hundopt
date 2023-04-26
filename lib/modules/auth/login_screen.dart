import 'package:flutter/material.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  LoginScreen({super.key});

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
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      StringConstants.iniciarSession,
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0,
                            MediaQuery.of(context).size.height * 0.05)),
                    Obx(() {
                      return CustomTextField(
                        isPassword: false,
                          labelText: StringConstants.email,
                          errorText: controller.lEmailErrText.value ?? "",
                          onChanged: controller.lEmailChanged);
                    }),
                    Obx(() {
                      return CustomTextField(
                        isPassword: true,
                          labelText: StringConstants.password,
                          errorText: controller.lPwdErrText.value ?? "",
                          onChanged: controller.lPwdChanged);
                    }),
                    Padding(padding: EdgeInsets.all(5)),
                    ClickableText(
                        uText: StringConstants.recuperar,
                        text: StringConstants.forgotPwd,
                        onPressed: () => controller.navigateToForgotPwd()),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0,
                            MediaQuery.of(context).size.height * 0.215)),

                    AppPrimaryButton(
                        text: StringConstants.iniciarSession,
                        onPressed: () => controller.login()),

                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0,
                            MediaQuery.of(context).size.height * 0.02)),
                    ClickableText(
                        uText: StringConstants.crearCuenta,
                        text: StringConstants.noAccount,
                        onPressed: () => controller.navigateToRegister())
                  ],
                ),
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
