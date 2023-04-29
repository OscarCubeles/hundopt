import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:hundopt/shared/widgets/progress_bar.dart';

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
                  ProgressBar(onBackPressed: controller.increment, onClosePressed: ()=>{}, progress: controller.progress)
                ],
              )),
        ));
  }
}
