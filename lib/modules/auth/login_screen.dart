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
                    const CustomTextField(
                        labelText: StringConstants.emailOrUser),
                    SizedBox(
                        // TODO: Change onerror for the form
                        child: Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      height: 50,
                      color: Colors.red,
                      child: Text("a"),
                    )),
                    const CustomTextField(labelText: StringConstants.password),
                    SizedBox(
                        // TODO: Change to onerror for the form
                        child: Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      height: 50,
                      color: Colors.red,
                      child: Text("a"),
                    )),
                    ClickableText(
                        uText: StringConstants.recuperar,
                        text: StringConstants.forgotPwd,
                        onPressed: () => {
                              Get.toNamed(Routes.AUTH + Routes.FORGOT_PASSWORD,
                                  arguments: controller)
                            }), // TODO: Add onpressed
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0,
                            MediaQuery.of(context).size.height * 0.215)),
                    AppPrimaryButton(
                        text: StringConstants.iniciarSession,
                        onPressed: () => {
                              Get.toNamed(Routes.AUTH + Routes.REGISTER,
                                  arguments: controller)
                              // TODO: CHange the place where it goes
                            }),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0,
                            MediaQuery.of(context).size.height * 0.02)),
                    ClickableText(
                        uText: StringConstants.crearCuenta,
                        text: StringConstants.noAccount,
                        onPressed: () => {
                              Get.toNamed(Routes.AUTH + Routes.REGISTER,
                                  arguments: controller)
                            }) // TODO: Add onpressed
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
