import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/setting_option.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

class SettingsController extends GetxController{

  RxnString userNameErrText = RxnString(null);
  RxnString emailErrText = RxnString(null);
  RxnString phoneErrText = RxnString(null);
  RxString userName = RxString('');
  RxString email = RxString('');
  RxString phone = RxString('');
  List<SettingOption> settingOptions = [];

  @override
  void onInit() {
    super.onInit();
    initFormFieldValidations();
    initSettingOptions();
  }

  void initSettingOptions(){
    settingOptions = [
      SettingOption(text: StringConstants.editProfileLabel, iconSource: CupertinoIcons.chevron_right, onPressed: toEditProfile),
      SettingOption(text: StringConstants.confirmChangePwdLabel, iconSource: CupertinoIcons.chevron_right, onPressed: showChangePasswordDialog),
      SettingOption(text: StringConstants.fillAdoptFormLabel, iconSource: CupertinoIcons.doc_plaintext, onPressed: toPersonalityForm),
      SettingOption(text: StringConstants.adoptStepsLabel, iconSource: CupertinoIcons.info, onPressed: showAdoptSteps),
      SettingOption(text: StringConstants.confirmCloseSessionLabel, iconSource: CupertinoIcons.power, onPressed: showCloseSessionDialog),
      SettingOption(text: StringConstants.confirmDeleteAccountLabel, iconSource: CupertinoIcons.trash, onPressed: showDeleteAccountDialog)
    ];
  }

  void initFormFieldValidations(){
    debounce<String>(userName, userNameValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(email, phoneValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(phone, phoneValidations,
        time: const Duration(milliseconds: 500));
  }

  void navigateToHome(){
    Get.toNamed(Routes.HOME, arguments: this);
  }

  void toPersonalityForm(){
    Get.toNamed(Routes.PERSONALITY_FORM);
  }

  void showDeleteAccountDialog(){
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleDeleteAccountText,
            text: StringConstants.bodyDeleteAccountText,
            buttonText: StringConstants.confirmDeleteAccountLabel,
            underlinedText: StringConstants.cancelLabel,
            buttonColor: ColorConstants.warningRed,
            onPressed: () => deleteAccount(),
            onClose: () => Get.back(),
            onTextPressed: () => Get.back(),
          );
        });
  }

  void deleteAccount(){
    // TODO: Delete the account
    Get.toNamed(Routes.AUTH, arguments: this);
  }

  void showCloseSessionDialog(){
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleCloseSessionText,
            text: StringConstants.bodyCloseSessionText,
            buttonText: StringConstants.confirmCloseSessionLabel,
            underlinedText: StringConstants.cancelLabel,
            buttonColor: ColorConstants.appColor,
            onPressed: () => closeSession(),
            onClose: () => Get.back(),
            onTextPressed: () => Get.back(),
          );
        });
  }

  void closeSession(){
    // TODO: Close Session
    Get.toNamed(Routes.AUTH);
  }

  void showChangePasswordDialog(){
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleChangePwdText,
            text: StringConstants.bodyChangePwdText,
            buttonText: StringConstants.confirmChangePwdLabel,
            underlinedText: StringConstants.cancelLabel,
            buttonColor: ColorConstants.appColor,
            onPressed: () => navigateToHome(),
            onClose: () => Get.back(),
            onTextPressed: () => Get.back(),
          );
        });
  }

  void userNameValidations(String value){

  }

  void emailValidations(String value){

  }

  void phoneValidations(String value){

  }


  void saveChanges(){
    // TODO: Check that the email, name and phone are valid before saving
    Get.back();
  }

  void toEditProfile(){
    Get.toNamed(Routes.SETTINGS + Routes.EDIT_PROFILE);
  }

  void showAdoptSteps(){
    // TODO: Show the informative message

  }

  void showExitDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleFormExitText,
            text: StringConstants.bodyFormExitText,
            buttonText: StringConstants.exitFormLabel,
            underlinedText: "",
            buttonColor: ColorConstants.appColor,
            onPressed: () => navigateToHome(),
            onClose: () => Get.back(),
            onTextPressed: () => Get.back(),
          );
        });
  }

}