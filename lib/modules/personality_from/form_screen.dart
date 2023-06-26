import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/shared.dart';
import 'form_controller.dart';

/// The [PersonalityFormScreen] class representing the screen showing the personality
/// form questions to the user
class PersonalityFormScreen extends GetView<FormController> {
  /// Constructs a new instance of the [PersonalityFormScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const PersonalityFormScreen({super.key});

  /// Builds the widget tree for the personality form questions screen.
  ///
  /// This method returns a [Container] widget containing a [SafeArea] widget
  /// with a [AppScaffold] that has an observable [SizedBox] that contains the
  /// current question widget with the question and possible form answers
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
                  SizedBox(
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
