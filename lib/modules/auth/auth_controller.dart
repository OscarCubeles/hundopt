import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/firebase_core.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';
import '../../shared/services/data_managers/singletons/user_singleton.dart';
import '../../shared/shared.dart';

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
      //TODO: Error messages are in english, should be translated
      fEmailErrText.value = e.message;
    }
  }

  Future<void> login() async {
    try {
      EasyLoading.show(status: 'Loading...');
      await signInWithEmailAndPassword();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        HundoptUser hundoptUser = await UserRepository().getUser(user.uid);
        //userManager.userData = hundoptUser; //TODO: CHeck if this can be commented
        UserManager().setUser(hundoptUser);
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
            rUsername.value, firebaseUser.email!, firebaseUser.uid, "");
        UserManager().setUser(HundoptUser.withEmailAndUsername(
            email: firebaseUser.email!, username: rUsername.value)
        );
        //TOD0: REMOVE THIS COMMENT IF NECESSARY
        //userManager.userData = HundoptUser.withEmailAndUsername(
        //    email: firebaseUser.email!, username: rUsername.value);
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
  }

  void navigateToForgotPwd() {
    Get.toNamed(Routes.AUTH + Routes.FORGOT_PASSWORD, arguments: this);
  }

  Future<void> createAndUploadDog() async {
    final dog30 = Dog(
      id: '30',
      age: 3,
      location: 'Barcelona',
      breed: 'Husky',
      description: 'Husky juguetón y cariñoso en busca de una familia activa.',
      friendly: ['Personas', 'Perros'],
      notFriendly: ['Gatos'],
      gender: 'Macho',
      personality: ['Leal', 'Juguetón'],
      healthPositive: ['Vacunado', 'Desparasitado'],
      healthNegative: [],
      isReserved: false,
      mainPictureURL:
          'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog31-1.jpg?alt=media&token=e1cceaca-0b30-451a-bbe8-d5c43f4195db&_gl=1*wrzwil*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwNTkuMC4wLjA.',
      pictureURLs: [
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog31-1.jpg?alt=media&token=e1cceaca-0b30-451a-bbe8-d5c43f4195db&_gl=1*wrzwil*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwNTkuMC4wLjA.",
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog31-2.jpg?alt=media&token=a67c8bd9-d4e4-446b-9b20-2defa22930ff&_gl=1*58rc0q*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwODEuMC4wLjA."
      ],
      shelterID: 'l0nKmZYIJpsFoBv3mJBq',
      size: 'L',
      name: 'Menta',
    );
    await DogRepository().uploadDog(dog30);
  }

  Future<void> createAndUploadChat() async {
    List<Message> messages = [
      Message(
          text: "Hola, me intersaria adoptarlo",
          date: "2023-05-08 10:00:00",
          isUser: true),
      Message(text: "Que bien!", date: "2023-05-08 10:01:00", isUser: false),
      Message(
          text: "Cuando podrias venir?",
          date: "2023-05-08 10:02:00",
          isUser: false),
    ];
    Chat chat = Chat(
      chatID: '',
      shelterID: 'l0nKmZYIJpsFoBv3mJBq',
      userID: 'IOGHSiIPsUYIyPhkEctJwYPDusE3',
      dogID: '4YCwkHj8Bjxm2EJXFb1a',
      lastMessageDate: "2023-05-08 10:05:00",
      messages: messages,
    );
    await ChatRepository().createChat(
      chat.shelterID,
      chat.userID,
      chat.dogID,
      chat.lastMessageDate,
      chat.messages,
    );
  }
}
