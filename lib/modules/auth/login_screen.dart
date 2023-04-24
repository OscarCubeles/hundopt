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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringConstants.iniciarSession,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.left,
                  ),
                  const CustomTextField(labelText: StringConstants.emailOrUser),
                  Padding(padding: EdgeInsets.all(10)),
                  const CustomTextField(labelText: StringConstants.password),
                  AppPrimaryButton(
                      text: StringConstants.iniciarSession,
                      onPressed: () => {
                            Get.toNamed(Routes.AUTH + Routes.REGISTER,
                                arguments: controller)
                          }),
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
