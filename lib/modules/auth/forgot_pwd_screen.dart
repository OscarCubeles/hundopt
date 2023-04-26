import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/widgets/dialogs.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/widgets.dart';
import 'auth_controller.dart';

class ForgotPassword extends StatelessWidget {
  final AuthController controller = Get.arguments;

  ForgotPassword({super.key});

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
                    StringConstants.recuperarPwd,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    child: Text(
                      StringConstants.infoRecuperarPwd,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const CustomTextField(labelText: StringConstants.email),
                  SizedBox(
                      child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: 50,
                    color: Colors.red,
                    child:
                        Text("a"), // TODO: Change this text to the error text
                  )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.24)),
                  AppPrimaryButton(
                      text: StringConstants.enviarEmail,
                      onPressed: () => controller.showResetPwdDialog()),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
                  ClickableText(
                      uText: StringConstants.atras,
                      text: StringConstants.noRecuperarPwd,
                      onPressed: () => controller.navigateToLogin()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
