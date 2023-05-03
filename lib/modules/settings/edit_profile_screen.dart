import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/settings/settings_controller.dart';
import 'package:hundopt/shared/shared.dart';

import '../../shared/constants/constants.dart';
import '../../shared/widgets/app_page.dart';

class EditProfileScreen extends GetView<SettingsController> {
  const EditProfileScreen({super.key});

  // TODO: Change the content for the user content
  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConstants.background,
        child: SafeArea(
            child: AppScaffold(
                showAppBar: false,
                child: Column(children: [
                  SettingsBar(
                      onTap: () => Get.back(),
                      icon: Icons.arrow_back,
                      titleLabel: StringConstants.editProfileLabel),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                        Stack(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () => {
                                    // TODO: Add open image gallery
                                  },
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg'),
                                    child: Icon(CupertinoIcons.switch_camera,
                                        size: 50,
                                        color: ColorConstants.transparentWhite),
                                  ),
                                )),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                              Text(StringConstants.userNameLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              Obx(() => EditProfileTextField(
                                    labelText: StringConstants.userNameLabel,
                                    errorText:
                                        controller.userNameErrText.value ?? "",
                                    initialValue: '',
                                    onChanged: controller.userNameChanged,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              Text(StringConstants.emailLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              Obx(() => EditProfileTextField(
                                    labelText: StringConstants.emailLabel,
                                    errorText:
                                        controller.emailErrText.value ?? "",
                                    initialValue: '',
                                    onChanged: controller.emailChanged,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              Text(StringConstants.phoneNumberLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              Obx(() => EditProfileTextField(
                                    labelText: StringConstants.phoneNumberLabel,
                                    errorText:
                                        controller.phoneErrText.value ?? "",
                                    initialValue: '',
                                    onChanged: controller.phoneChange,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      MediaQuery.of(context).size.height * 0.2,
                                      0,
                                      0)),
                              AppPrimaryButton(
                                  text: StringConstants.saveLabel,
                                  onPressed: controller.saveChanges)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]))));
  }
}
