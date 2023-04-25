import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.05)),
                  const CustomTextField(labelText: StringConstants.email),
                  SizedBox(
                      // TODO: Change onerror for the form
                      child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: 50,
                    color: Colors.red,
                    child: Text("a"),
                  )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.26)),
                  AppPrimaryButton(
                      text: StringConstants.enviarEmail,
                      onPressed: () => {
                            Get.toNamed(Routes.AUTH + Routes.REGISTER,
                                arguments: controller) // TODO: Change the route
                          }),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
                  ClickableText(
                      uText: StringConstants.atras,
                      text: StringConstants.noRecuperarPwd,
                      onPressed: () => {Get.toNamed(Routes.AUTH + Routes.LOGIN)}), // TODO: Add onpressed
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
