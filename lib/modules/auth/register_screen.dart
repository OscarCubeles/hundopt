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
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height*0.05)),
                  //CustomTextField(labelText: StringConstants.nombreUsuario, errorText: "", onChanged: null,),
                SizedBox(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      height: 50,
                      color: Colors.red,
                      child: Text("a"),// TODO: Change onerror text for the form
                    )
                ),
                  //CustomTextField(labelText: StringConstants.email, errorText: "", onChanged: null,),
                  SizedBox(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        height: 50,
                        color: Colors.red,
                        child: Text("a"), // TODO: Change onerror for the form
                      )
                  ),
                  //CustomTextField(labelText: StringConstants.password, errorText: '', onChanged: null,),
                  SizedBox(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        height: 50,
                        color: Colors.red,
                        child: Text("a"), // TODO: Change onerror for the form
                      )
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height*0.175)),
                  AppPrimaryButton(
                      text: StringConstants.crearCuenta,
                      onPressed: () => controller.register()),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height*0.02)),
                  ClickableText(uText: StringConstants.iniciarSession, text: StringConstants.yesAccount, onPressed: () => {
                    Get.toNamed(Routes.AUTH + Routes.LOGIN,
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
          children: [
          ],
        ),
      ),
    );
  }
}
