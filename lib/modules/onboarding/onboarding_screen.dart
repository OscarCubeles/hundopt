import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/shared/shared.dart';
import 'onboarding.dart';

/// The [OnboardingScreen] class representing the screen with the welcome
/// message shown to a user that has just registered to the app
class OnboardingScreen extends GetView<OnboardingController> {
  /// Constructs a new instance of the [OnboardingScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const OnboardingScreen({super.key});

  /// Builds the widget tree for the onboarding screen.
  ///
  /// This method returns a [Container] widget containing a [SafeArea] widget
  /// with a [Column] with all the welcome messages, the buttons to
  /// redirect the user to the app or to the personality form
  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConstants.background,
        child: SafeArea(
          child: AppScaffold(
              showAppBar: true,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      StringConstants.welcomeLabel,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01)),
                  Text(
                    StringConstants.welcomeText,
                    style: Styles.bodySmall,
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.091)),
                  AppPrimaryButton(
                      text: StringConstants.fillFormLabel,
                      onPressed: controller.navigateToForm),
                  Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01)),
                  ClickableText(
                      uText: StringConstants.onlyExploreText,
                      text: "",
                      onPressed: controller.navigateToExplore)
                ],
              )),
        ));
  }
}
