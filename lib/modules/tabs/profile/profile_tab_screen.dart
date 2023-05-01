import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/tabs/profile/profile_tab_controller.dart';

import '../../../shared/widgets/app_page.dart';

class ProfileTab extends GetView<ProfileController> {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showSettings: true,
      showAppBar: true,
      onSettingsPressed: controller.onSettingsPressed,
      child: Column(
        children: [

        ],
      ),
    );
  }
}
