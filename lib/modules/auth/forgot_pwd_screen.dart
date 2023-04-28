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
    AuthController fx = Get.put(AuthController()); // controller
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
                    StringConstants.recuperatePwdText,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    child: Text(
                      StringConstants.infoRecuperatePwdText,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Obx(() {
                    return CustomTextField(
                      isPassword: false,
                        labelText: StringConstants.emailLabel,
                        errorText: fx.fEmailErrText.value ?? "",
                        onChanged: fx.fEmailChanged);
                  }),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.24)),
                  Obx(() =>
                    AppPrimaryButton(
                      text: StringConstants.sendEmailLabel,
                      onPressed: fx.submitFunc.value!,
                    )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
                  ClickableText(
                      uText: StringConstants.backLabel,
                      text: StringConstants.noRecuperatePwdText,
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
