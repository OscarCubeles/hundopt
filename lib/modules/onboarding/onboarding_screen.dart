import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/shared/shared.dart';

import '../../shared/constants/constants.dart';
import '../../shared/widgets/app_page.dart';
import 'onboarding.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

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
                  Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.01)),
                  Text(StringConstants.welcomeText,
                      style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.justify,),
                  Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.091)),
                  AppPrimaryButton(text: StringConstants.fillFormLabel, onPressed: controller.navigateToForm),
                  Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.01)),
                  ClickableText(uText: StringConstants.onlyExploreText, text: "", onPressed: controller.navigateToExplore)
                ],
              )),
        ));
  }
}
