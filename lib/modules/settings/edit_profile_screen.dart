import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/settings/settings_controller.dart';
import 'package:hundopt/shared/shared.dart';

/// The [EditProfileScreen] class representing the screen the text fields
/// that allow the user to change their email, username and phone number.
/// Also, it allows the user to change its profile image.
class EditProfileScreen extends GetView<SettingsController> {
  /// Constructs a new instance of the [EditProfileScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const EditProfileScreen({super.key});

  /// Builds the widget tree for the personality form questions screen.
  ///
  /// This method returns a [Container] widget containing a [SafeArea] widget
  /// with a [AppScaffold] that has a [Column] widget with all the [EditProfileTextField]
  /// that allow the user to modify its user data
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                        Stack(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () =>
                                      {controller.uploadImageToFirebase()},
                                  child: Obx(() => CircleAvatar(
                                        radius: 50,
                                        backgroundImage: controller
                                                    .user.value.pictureURL !=
                                                ""
                                            ? NetworkImage(controller
                                                .user.value.pictureURL)
                                            : Image.asset(
                                                fit: BoxFit.fill,
                                                AssetsPath.defaultProfilePic,
                                              ).image,
                                        child: Icon(
                                            CupertinoIcons.switch_camera,
                                            size: 50,
                                            color: ColorConstants
                                                .transparentWhite),
                                      )),
                                )),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                              Text(StringConstants.userNameLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              Obx(() => EditProfileTextField(
                                    labelText: StringConstants.userNameLabel,
                                    errorText:
                                        controller.userNameErrText.value ?? "",
                                    initialValue: controller.userName.value,
                                    onChanged: controller.userNameChanged,
                                  )),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              Text(StringConstants.emailLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              Obx(() => EditProfileTextField(
                                    labelText: StringConstants.emailLabel,
                                    errorText:
                                        controller.emailErrText.value ?? "",
                                    initialValue: controller.email.value,
                                    onChanged: controller.emailChanged,
                                  )),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              Text(StringConstants.phoneNumberLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              Obx(() => EditProfileTextField(
                                    labelText: StringConstants.phoneNumberLabel,
                                    errorText:
                                        controller.phoneErrText.value ?? "",
                                    initialValue: controller.phone.value,
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
