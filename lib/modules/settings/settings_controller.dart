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

/// The [SettingsController] This class is responsible for managing the settings of the user.
/// It contains methods for validating and saving user data, as well as navigating to different screens and dialogs.
class SettingsController extends GetxController {
  /// A reactive full name error text.
  RxnString userNameErrText = RxnString(null);

  /// A reactive email error text.
  RxnString emailErrText = RxnString(null);

  /// A reactive phone error text.
  RxnString phoneErrText = RxnString(null);

  /// A reactive username.
  RxString userName = RxString('');

  /// A reactive email.
  RxString email = RxString('');

  /// A reactive phone.
  RxString phone = RxString('');

  /// A list of the setting options.
  List<SettingOption> settingOptions = [];

  /// A boolean indicating if the user data is valid.
  bool dataIsValid = false;

  /// A reactive user.
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

  /// Initializes the setting options.
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

  /// Initializes the form field validations.
  void initFormFieldValidations() {
    debounce<String>(userName, usernameValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(email, emailValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(phone, phoneValidations,
        time: const Duration(milliseconds: 500));
  }

  /// Navigates to the Home screen.
  void navigateToHome() async {
    final ProfileController profileController = Get.find<ProfileController>();
    profileController.setScreenValues();
    Get.offNamed(Routes.HOME, arguments: 3);
  }

  /// Navigates to the Personality Form screen.
  void toPersonalityForm() {
    Get.toNamed(Routes.PERSONALITY_FORM);
  }

  /// Shows the delete account dialog warning the user that he/she will not be
  /// able to recover the account.
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

  /// Deletes the user account from the DB and deletes everything from Get cache.
  void deleteAccount() {
    Auth().deleteUser();
    Get.toNamed(Routes.AUTH, arguments: this);
  }

  /// Shows the close session dialog informing the user that its session will be closed
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

  /// Closes the session of the current user and deletes everything from Get cache
  void closeSession() async {
    await Auth().signOut();
    Get.offNamed(Routes.AUTH);
  }

  /// Sends an email to the user's email with the steps to change its password
  Future<void> sendPwdChangeEmail() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await Auth().sendPasswordResetEmail(email: firebaseUser.email!);
    }
    Get.back();
  }

  /// Shows a dialog informing the user that if he confirms the dialog, an email
  /// will be sent to its email in order to change its password
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

  /// Handles the username input change.
  ///
  /// The [val] parameter is the new value of the username input.
  void userNameChanged(String value) {
    userName.value = value;
  }

  /// Handles the email input change.
  ///
  /// The [val] parameter is the new value of the email input.
  void emailChanged(String value) {
    email.value = value;
  }

  /// Handles the phone number input change.
  ///
  /// The [val] parameter is the new value of the phone number input.
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

  /// Validates the phone input.
  ///
  /// The [val] parameter is the phone number input.
  void phoneValidations(String val) {
    phoneErrText.value = null; // reset validation errors to nothing
    if (val.isNotEmpty) {
      if (Validations().hasCountryCode(val, phoneErrText) &&
          Validations().isValidNumber(val, phoneErrText)) {
        phoneErrText.value = "";
      }
    }
  }

  /// Validates the username input.
  ///
  /// The [val] parameter is the phone username input.
  void usernameValidations(String value) {
    userNameErrText.value = null;
    if (value.isNotEmpty) {
      if (Validations.isValidUsername(value, userNameErrText) &&
          Validations.lengthOK(value, userNameErrText)) {
        userNameErrText.value = "";
      }
    }
  }

  /// This method returns a boolean value indicating whether the user input is valid.
  /// It checks if the username, email, and phone number are valid and non-null.
  bool isDataValid() {
    return (userNameErrText.value == "" || userNameErrText.value == null) &&
        (emailErrText.value == "" || emailErrText.value == null) &&
        (phoneErrText.value == "" || phoneErrText.value == null);
  }

  ///This method saves the changes made by the user. It first checks if the user input is valid using the isDataValid method.
  ///If the input is valid, it updates the user's email, phone number, and username in the Firebase authentication and Firestore database.
  void saveChanges() async {
    bool updateOk = false;
    try {
      EasyLoading.show(status: StringConstants.loadingLabel);
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

  /// This method navigates the user to the edit profile screen.
  void toEditProfile() {
    Get.toNamed(Routes.SETTINGS + Routes.EDIT_PROFILE);
  }

  /// This method shows the user the steps required to adopt a pet.
  void showAdoptSteps() {
    Get.toNamed(Routes.SETTINGS + Routes.ADOPT_STEPS);
  }

  /// This method navigates the user back to the previous screen.
  void navigateBack() {
    Get.back();
  }

  /// This method shows a dialog to the user asking if they want to exit the form.
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

  /// This method uploads the user's profile picture to Firebase storage and
  /// updates the user's profile picture URL in the Firestore database.
  void uploadImageToFirebase() async {
    final imageUrl = await UserRepository().uploadImage();
    if (imageUrl != null) {
      await UserRepository().updatePictureURL(user.value.id, imageUrl);
      user.value.pictureURL = imageUrl;
      update();
    }
  }
}
