import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/setting_option.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

class SettingsController extends GetxController {
  RxnString userNameErrText = RxnString(null);
  RxnString emailErrText = RxnString(null);
  RxnString phoneErrText = RxnString(null);
  RxString userName = RxString('');
  RxString email = RxString('');
  RxString phone = RxString('');
  List<SettingOption> settingOptions = [];
  bool dataIsValid = false;

  @override
  void onInit() {
    super.onInit();
    initFormFieldValidations();
    initSettingOptions();
  }

  void initSettingOptions() {
    settingOptions = [
      SettingOption(
          text: StringConstants.editProfileLabel,
          iconSource: CupertinoIcons.chevron_right,
          onPressed: toEditProfile),
      SettingOption(
          text: StringConstants.confirmChangePwdLabel,
          iconSource: CupertinoIcons.chevron_right,
          onPressed: showChangePasswordDialog),
      SettingOption(
          text: StringConstants.fillAdoptFormLabel,
          iconSource: CupertinoIcons.doc_plaintext,
          onPressed: toPersonalityForm),
      SettingOption(
          text: StringConstants.adoptStepsLabel,
          iconSource: CupertinoIcons.info,
          onPressed: showAdoptSteps),
      SettingOption(
          text: StringConstants.confirmCloseSessionLabel,
          iconSource: CupertinoIcons.power,
          onPressed: showCloseSessionDialog),
      SettingOption(
          text: StringConstants.confirmDeleteAccountLabel,
          iconSource: CupertinoIcons.trash,
          onPressed: showDeleteAccountDialog)
    ];
  }

  void initFormFieldValidations() {
    debounce<String>(userName, usernameValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(email, emailValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(phone, phoneValidations,
        time: const Duration(milliseconds: 500));
  }

  void navigateToHome() {
    Get.offNamed(Routes.HOME, arguments: 3);
  }

  void toPersonalityForm() {
    Get.toNamed(Routes.PERSONALITY_FORM);
  }

  void showDeleteAccountDialog() {
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

  void deleteAccount() {
    // TODO: Delete the account
    Get.toNamed(Routes.AUTH, arguments: this);
  }

  void showCloseSessionDialog() {
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

  void closeSession() {
    // TODO: Close Session
    Get.offNamed(Routes.AUTH);
  }

  void showChangePasswordDialog() {
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

  void userNameChanged(String value) {
    userName.value = value;
  }

  void emailChanged(String value) {
    email.value = value;
  }

  void phoneChange(String value) {
    phone.value = value;
  }

  void emailValidations(String val) {
    emailErrText.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (isValidEmail(val, emailErrText /*&& await available(val)*/)) {
        //FUTURE TODO: Change available function to check if the email exists)) {
        emailErrText.value = "";
      }
    }
  }

  void phoneValidations(String val) {
    phoneErrText.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (hasCountryCode(val, phoneErrText) && isValidNumber(val, phoneErrText)) {
        emailErrText.value = "";
      }
    }
  }

  bool isValidEmail(String val, RxnString errText) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val)) {
      errText.value = 'Formato de email no válido.';
      return false;
    }
    return true;
  }

  bool hasCountryCode(String val, RxnString errText) {
    if (!RegExp(r'^\+\d{1,3}(?:\(\d{1,4}\))?(?:\s|)?').hasMatch(val)) {
      errText.value = 'Añade el código de país.';
      return false;
    }
    return true;
  }

  bool isValidNumber(String val, RxnString errText) {
    if (!RegExp(r'^\+(?:[0-9]●?){6,14}[0-9]$').hasMatch(val)) {
      errText.value = 'Número de digitos incorrecto. No añada espacios.';
      return false;
    }
    return true;
  }

  void usernameValidations(String value) {
    userNameErrText.value = null; // reset validation errors to nothing
    if (value.isNotEmpty) {
      if (lengthOK(value, userNameErrText /*&& await available(val)*/)) {
        //FUTURE TODO: Change available function to check if the username exists)) {
        userNameErrText.value = "";
      }
    }
  }

  bool lengthOK(String val, RxnString err, {int minLen = 8}) {
    if (val.length < minLen) {
      err.value = 'La longitud mínima es de 8 caracteres';
      return false;
    }
    return true;
  }

  void saveChanges() {
    // TODO: Check that the email or username are not from users that already exist
    if(dataIsValid){
      Get.back();
    }
  }

  void toEditProfile() {
    Get.toNamed(Routes.SETTINGS + Routes.EDIT_PROFILE);
  }

  void showAdoptSteps() {
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
