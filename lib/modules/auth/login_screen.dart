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
                    /*CustomTextField(
                        labelText: StringConstants.emailOrUser,errorText: "", onChanged: null),*/
                    SizedBox(

                        child: Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      height: 50,
                      color: Colors.red,
                      child: Text("a"),// TODO: Change onerror text for the form
                    )),
                    //CustomTextField(labelText: StringConstants.password, errorText: "", onChanged: null,),
                    SizedBox(

                        child: Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      height: 50,
                      color: Colors.red,
                      child: Text("a"), // TODO: Change to onerror text for the form
                    )),
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
