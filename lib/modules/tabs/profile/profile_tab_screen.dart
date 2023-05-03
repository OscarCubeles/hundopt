import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/tabs/profile/profile_tab_controller.dart';
import 'package:hundopt/shared/constants/colors.dart';
import 'package:hundopt/shared/shared.dart';

import '../../../shared/widgets/app_bar.dart';
import '../../../shared/widgets/app_page.dart';

class ProfileTab extends GetView<ProfileController> {
  const ProfileTab({super.key});

  /*
   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: showAppBar ?  MainAppBar(showSettings: showSettings,onSettingsPressed: onSettingsPressed,) : null,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: ColorConstants.background,
              child: child

          )
        ])));
  }
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          showSettings: true, onSettingsPressed: controller.onSettingsPressed),
      body: Container(
        color: ColorConstants.background,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.username,
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(
                        controller.fullName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg')),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            HorizontalBar(),
          ],
        ),
      ),
    );
  }
}
