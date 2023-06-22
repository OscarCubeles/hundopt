import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../api/firebase_core/firebase_core.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';
import '../../shared/shared.dart';
import '../home/tabs/profile/profile_tab_controller.dart';

class SettingsController extends GetxController {
  RxnString userNameErrText = RxnString(null);
  RxnString emailErrText = RxnString(null);
  RxnString phoneErrText = RxnString(null);
  RxString userName = RxString('');
  RxString email = RxString('');
  RxString phone = RxString('');
  List<SettingOption> settingOptions = [];
  bool dataIsValid = false;
  Rx<HundoptUser> user = HundoptUser.empty().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    initFormFieldValidations();
    initSettingOptions();
    user.value = await Auth().retrieveUser() as HundoptUser;
    userName.value = user.value.username;
    email.value = user.value.email;
    phone.value = user.value.phone;
  }

  void initSettingOptions() {
    settingOptions = [
      SettingOption(
          text: StringConstants.editProfileLabel,
          iconSource: CupertinoIcons.chevron_right,
          onPressed: toEditProfile),
      SettingOption(
          text: StringConstants.changePwdLabel,
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

  void navigateToHome() async {
    final ProfileController profileController =
    Get.find<ProfileController>();
    profileController.setScreenValues();
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

  void closeSession() async {
    await Auth().signOut();
    Get.offNamed(Routes.AUTH);
  }

  Future<void> sendPwdChangeEmail() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await Auth().sendPasswordResetEmail(email: firebaseUser.email!);
    }
    Get.back();
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
            onPressed: () => sendPwdChangeEmail(),
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
      if (Validations.isValidEmail(val, emailErrText)) {
        emailErrText.value = "";
      }
    }
  }

  void phoneValidations(String val) {
    phoneErrText.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (Validations().hasCountryCode(val, phoneErrText) &&
          Validations().isValidNumber(val, phoneErrText)) {
        phoneErrText.value = "";
      }
    }
  }

  void usernameValidations(String value) {
    userNameErrText.value = null;
    if (value.isNotEmpty) {
      if (Validations.isValidUsername(value, userNameErrText) &&
          Validations.lengthOK(value, userNameErrText)) {
        userNameErrText.value = "";
      }
    }
  }

  bool isDataValid() {
    return (userNameErrText.value == "" || userNameErrText.value == null) &&
        (emailErrText.value == "" || emailErrText.value == null) &&
        (phoneErrText.value == "" || phoneErrText.value == null);
  }

  void saveChanges() async {
    // TODO: Change profile picture
    bool updateOk = false;
    try {
      EasyLoading.show(status: 'Loading...');
      if (isDataValid()) {
        updateOk = await Auth().changeUserEmail(
            email.value, phoneErrText); // Changing the email in auth
        updateOk = updateOk &&
            await UserRepository().updateUser(
                email.value,
                phone.value,
                userName.value,
                phoneErrText); // Changing the values in firestoreDB
      }
    } finally {
      EasyLoading.dismiss();
      if (updateOk) {
        Get.back();
      }
    }
  }

  void toEditProfile() {
    Get.toNamed(Routes.SETTINGS + Routes.EDIT_PROFILE);
  }

  void showAdoptSteps() {
    Get.toNamed(Routes.SETTINGS + Routes.ADOPT_STEPS);
  }

  void navigateBack() {
    Get.back();
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

  void uploadImageToFirebase() async {
    final imageUrl = await UserRepository().uploadImage();
    if (imageUrl != null) {
      await UserRepository().updatePictureURL(user.value.id, imageUrl);
      user.value.pictureURL = imageUrl;
      update();
    }
  }
}
