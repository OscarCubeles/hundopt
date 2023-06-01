import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../api/api_repository.dart';
import '../../api/firebase_core/auth.dart';
import '../../api/firebase_core/user_repository.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/utils/validations.dart';
import '../../shared/widgets/dialogs.dart';

// TODO: source of the form code: https://stackoverflow.com/questions/64544571/flutter-getx-forms-validation
class AuthController extends GetxController {
  RxnString fEmailErrText = RxnString(null);
  RxnString rEmailErrText = RxnString(null);
  RxnString rUsernameErrText = RxnString("");
  RxnString rPwdErrText = RxnString(null);
  RxnString lEmailErrText = RxnString(null);
  RxnString lPwdErrText = RxnString(null);
  RxString fEmail = RxString('');
  RxString rEmail = RxString('');
  RxString rUsername = RxString('');
  RxString rPwd = RxString('');
  RxString lEmail = RxString('');
  RxString lPwd = RxString('');
  late final ApiRepository apiRepository;

  Rxn<Function()> submitFunc = Rxn<Function()>(() => {});

  @override
  void onInit() {
    super.onInit();
    apiRepository = Get.find();
    initFormFieldValidators();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void initFormFieldValidators() {
    debounce<String>(fEmail, fEmailValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(lEmail, lEmailValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(lPwd, lPwdValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(rEmail, rEmailValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(rUsername, rUsernameValidations,
        time: const Duration(milliseconds: 500));
    debounce<String>(rPwd, rPwdValidations,
        time: const Duration(milliseconds: 500));
  }

  void fEmailValidations(String val) async {
    fEmailErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (Validations.isValidEmail(val, fEmailErrText)) {
        submitFunc.value = () {
          sendResetPwdEmail();
        };
        fEmailErrText.value = "";
      }
    }
  }

  void lEmailValidations(String val) async {
    lEmailErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (Validations.isValidEmail(
          val, lEmailErrText) /*&& await available(val)*/) {
        //FUTURE TODO: Change available function to check if the email exists
        submitFunc.value = () {};
        lEmailErrText.value = "";
      }
    }
  }

  void lPwdValidations(String val) async {
    lPwdErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (Validations.lengthOK(val, lPwdErrText, minLen: 3)) {
        submitFunc.value = () {};
        lPwdErrText.value = "";
      }
    }
  }

  void rEmailValidations(String val) async {
    rEmailErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (Validations.isValidEmail(
          val, rEmailErrText /*&& await available(val)*/)) {
        //FUTURE TODO: Change available function to check if the email exists)) {
        submitFunc.value = () {};
        rEmailErrText.value = "";
      }
    }
  }

  void rUsernameValidations(String val) async {
    rUsernameErrText.value = null; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (Validations.lengthOK(
          val, rUsernameErrText /*&& await available(val)*/)) {
        //FUTURE TODO: Change available function to check if the username exists)) {
        submitFunc.value = () {};
        rUsernameErrText.value = "";
      }
    }
  }

  void rPwdValidations(String val) async {
    rPwdErrText.value = ""; // reset validation errors to nothing
    submitFunc.value = () => {}; // disable submit while validating
    if (val.isNotEmpty) {
      if (Validations.isValidPassword(val, rPwdErrText) &&
          Validations.lengthOK(val, rPwdErrText)) {
        submitFunc.value = () {};
        rPwdErrText.value = "";
      }
    }
  }

  Future<bool> available(String val) async {
    print('Query availability of: $val');
    await Future.delayed(
        const Duration(seconds: 1), () => print('Available query returned'));
    if (val == "Sylvester") {
      fEmailErrText.value = 'Name Taken';
      return false;
    }
    return true;
  }

  void fEmailChanged(String val) {
    fEmail.value = val;
  }

  void lEmailChanged(String val) {
    lEmail.value = val;
  }

  void rEmailChanged(String val) {
    rEmail.value = val;
  }

  void rUsernameChanged(String val) {
    rUsername.value = val;
  }

  void lPwdChanged(String val) {
    lPwd.value = val;
  }

  void rPwdChanged(String val) {
    rPwd.value = val;
  }

  Function() sendForgotPwdEmail() {
    return () {};
  }

  Future<bool> Function() submitFunction() {
    return () async {
      print('Make database call to create ${fEmail.value} account');
      await Future.delayed(
          const Duration(seconds: 1), () => print('User account created'));
      return true;
    };
  }

  void sendResetPwdEmail() async {
    try {
      EasyLoading.show(status: 'Loading...');
      await sendPasswordResetEmail();
    } finally {
      EasyLoading.dismiss();
    }

  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await Auth().sendPasswordResetEmail(
        email: fEmail.value,
      );
      showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return NotificationDialog(
              title: StringConstants.sentEmailLabel,
              text: StringConstants.resetPwdText,
              buttonText: StringConstants.continueLabel,
              underlinedText: "",
              buttonColor: ColorConstants.appColor,
              onPressed: () => navigateToLogin(),
              onClose: () => Get.back(),
              onTextPressed: () => {},
            );
          });
    } on FirebaseAuthException catch (e) {
      fEmailErrText.value = e.message; //TODO: Error messages are in english, should be translated
    }
  }

  Future<void> login() async {
    try {
      EasyLoading.show(status: 'Loading...');
      await signInWithEmailAndPassword();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // TODO: Create app user
        Get.toNamed(Routes.HOME, arguments: 0);
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  void register() async {
    try {
      EasyLoading.show(status: 'Loading...');
      await createUserWithEmailAndPassword(); //TODO: Create user profile with this user in firebase storage
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await UserRepository().createUser(rUsername.value, user.email!, user.uid);
        Get.toNamed(Routes.ONBOARDING);
      }
    } finally {
      EasyLoading.dismiss();
    }
  }


  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: rEmail.value,
        password: rEmail.value,
      );
    } on FirebaseAuthException catch (e) {
      lPwdErrText.value = e.message;
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: lEmail.value,
        password: lPwd.value,
      );
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      lPwdErrText.value = e.message;
    }
  }

  void navigateToLogin() {
    Get.offAndToNamed(Routes.AUTH + Routes.LOGIN, arguments: this);
  }

  void navigateToRegister() {
    Get.offAndToNamed(Routes.AUTH + Routes.REGISTER, arguments: this);
  }

  void navigateToForgotPwd() {
    Get.offAndToNamed(Routes.AUTH + Routes.FORGOT_PASSWORD, arguments: this);
  }
}
