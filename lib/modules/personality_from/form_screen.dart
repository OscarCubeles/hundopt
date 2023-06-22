import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/shared.dart';
import 'form_controller.dart';

class PersonalityFormScreen extends GetView<FormController> {
  const PersonalityFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConstants.background,
        child: SafeArea(
          child: AppScaffold(
              showAppBar: false,
              child: Column(
                children: [
                  ProgressBar(
                      onBackPressed: controller.previousQuestion,
                      onClosePressed: controller.showExitDialog,
                      progress: controller.progress),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Obx(() {
                      return controller
                          .questionWidgets[controller.currentQuestion.value];
                    }),
                  ),
                  AppPrimaryButton(
                      text: StringConstants.continueLabel,
                      onPressed: controller.continuePressed)
                ],
              )),
        ));
  }
}
