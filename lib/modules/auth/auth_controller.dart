import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/dog_repository.dart';

import '../../api/firebase_core/auth.dart';
import '../../api/firebase_core/user_repository.dart';
import '../../models/dog.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/services/user_singleton.dart';
import '../../shared/utils/validations.dart';
import '../../shared/widgets/dialogs.dart';
import '../../models/user.dart';

// TODO: source of the form code: https://stackoverflow.com/questions/64544571/flutter-getx-forms-validation
class AuthController extends GetxController {
  final userManager = UserSingleton();
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

  Rxn<Function()> submitFunc = Rxn<Function()>(() => {});

  @override
  void onInit() {
    super.onInit();
    initFormFieldValidators();
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
      if (Validations.isValidEmail(val, lEmailErrText)) {
        submitFunc.value = () {};
        lEmailErrText.value = "";
      }
    }
  }

  void lPwdValidations(String val) async {
    lPwdErrText.value = null;
    submitFunc.value = () => {};
    if (val.isNotEmpty) {
      if (Validations.lengthOK(val, lPwdErrText, minLen: 3)) {
        submitFunc.value = () {};
        lPwdErrText.value = "";
      }
    }
  }

  void rEmailValidations(String val) async {
    rEmailErrText.value = null;
    submitFunc.value = () => {};
    if (val.isNotEmpty) {
      if (Validations.isValidEmail(val, rEmailErrText)) {
        submitFunc.value = () {};
        rEmailErrText.value = "";
      }
    }
  }

  void rUsernameValidations(String val) async {
    rUsernameErrText.value = null;
    submitFunc.value = () => {};
    if (val.isNotEmpty) {
      if (Validations.isValidUsername(val, rUsernameErrText) &&
          Validations.lengthOK(val, rUsernameErrText)) {
        submitFunc.value = () {};
        rUsernameErrText.value = "";
      }
    }
  }

  void rPwdValidations(String val) async {
    rPwdErrText.value = "";
    submitFunc.value = () => {};
    if (val.isNotEmpty) {
      if (Validations.isValidPassword(val, rPwdErrText) &&
          Validations.lengthOK(val, rPwdErrText)) {
        submitFunc.value = () {};
        rPwdErrText.value = "";
      }
    }
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
      fEmailErrText.value =
          e.message; //TODO: Error messages are in english, should be translated
    }
  }

  Future<void> login() async {
    try {
      EasyLoading.show(status: 'Loading...');
      await signInWithEmailAndPassword();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // TODO: get the user that logged in in the singleton
        HundoptUser hundoptUser = await UserRepository().getUser(user.uid);
        // Set the userData property of the UserManager singleton
        userManager.userData = hundoptUser;
        Get.toNamed(Routes.HOME, arguments: 0);
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  void register() async {
    try {
      EasyLoading.show(status: 'Loading...');
      await createUserWithEmailAndPassword();
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        await UserRepository().createUser(
            rUsername.value,
            firebaseUser.email!,
            firebaseUser.uid,
            rPwd.value); // TODO : REMOVE THE PWD AFTER TESTING
        // Set the userData property of the UserManager singleton
        userManager.userData = HundoptUser.withEmailAndUsername(
            email: firebaseUser.email!, username: rUsername.value);

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
        password: rPwd.value,
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
    Get.toNamed(Routes.AUTH + Routes.REGISTER, arguments: this);
    createAndUploadDog();
  }

  //TODO: removee this after creating all dogs n DB
  Future<void> createAndUploadDog() async {
    final dog = Dog(
      id: '10',
      age: 1,
      location: 'Manresa',
      breed: 'Caniche Toy',
      description:
          'Perra muy tímida y poco movida que le gusta quedarse en casa y tomar el sol.',
      friendly: [],
      notFriendly: ['Gato Hembra', 'Perro Hembra', 'Perro Mahco',"Gato Macho"],
      gender: 'Hembra',
      personality: [
        "Tímido",
        "Tranquilo",
        "Leal"
      ],
      healthPositive: ['Microchip',  'Esterilizado'],
      healthNegative: ['No Vacunado'],
      isReserved: false,
      mainPictureURL:
          'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog11.jpg?alt=media&token=9190d2b4-a3b2-4e8b-a987-dfcc39e3bfaa&_gl=1*9gispm*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NTk5MTgxMi4xMy4xLjE2ODU5OTI2NDAuMC4wLjA.',
      pictureURLs: [
        'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog11.jpg?alt=media&token=9190d2b4-a3b2-4e8b-a987-dfcc39e3bfaa&_gl=1*9gispm*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NTk5MTgxMi4xMy4xLjE2ODU5OTI2NDAuMC4wLjA.'
      ],
      shelterID: 'l0nKmZYIJpsFoBv3mJBq',
      size: 'XS',
      name: 'Trufa',
    );

    // Upload the dog to Firebase Firestore
    await DogRepository().uploadDog(dog);
  }

  void navigateToForgotPwd() {
    Get.toNamed(Routes.AUTH + Routes.FORGOT_PASSWORD, arguments: this);
  }
}
