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
    //createAndUploadDog(); //TODO: UNcoment this line if dogs need to be restored
  }

  //TODO: removee this after creating all dogs in DB
  Future<void> createAndUploadDog() async {
    final dog22 = Dog(
      id: '22',
      age: 2,
      location: 'Barcelona',
      breed: 'Dálmata',
      description: 'Dálmata juguetón y sociable en busca de un hogar amoroso.',
      friendly: ['Perros', 'Gatos'],
      notFriendly: ['Personas desconocidas'],
      gender: 'Macho',
      personality: ['Activo', 'Amigable'],
      healthPositive: ['Vacunado', 'Desparasitado'],
      healthNegative: [],
      isReserved: false,
      mainPictureURL: 'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog23-1.jpg?alt=media&token=94a5e51d-154d-4015-893a-e41baeab3082&_gl=1*ay8zok*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjczMjkuMC4wLjA.',
      pictureURLs: [
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog23-1.jpg?alt=media&token=94a5e51d-154d-4015-893a-e41baeab3082&_gl=1*ay8zok*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjczMjkuMC4wLjA.",
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog23-2.jpg?alt=media&token=8fb28d70-0802-4864-88a3-a73828655820&_gl=1*1l1wbqx*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc1NDcuMC4wLjA."
      ],
      shelterID: 'l0nKmZYIJpsFoBv3mJBq',
      size: 'M',
      name: 'Rocky',
    );
    await DogRepository().uploadDog(dog22);
    final dog23 = Dog(
      id: '23',
      age: 1,
      location: 'Madrid',
      breed: 'Dálmata',
      description: 'Dálmata travieso y lleno de energía en busca de una familia activa.',
      friendly: ['Niños', 'Otros perros'],
      notFriendly: ['Gatos'],
      gender: 'Hembra',
      personality: ['Juguetón', 'Curioso'],
      healthPositive: ['Vacunado'],
      healthNegative: [],
      isReserved: false,
      mainPictureURL: 'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog24-1.jpg?alt=media&token=b3c145c1-50f1-43d4-952f-b4cf627fa250&_gl=1*1ymwox7*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc1NjAuMC4wLjA.',
      pictureURLs: ["https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog24-1.jpg?alt=media&token=b3c145c1-50f1-43d4-952f-b4cf627fa250&_gl=1*1ymwox7*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc1NjAuMC4wLjA.",
      "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog24-2.jpg?alt=media&token=81854384-cf8d-4d75-ba12-703e43d82d97&_gl=1*18a6osn*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc1ODUuMC4wLjA."
      ],
      shelterID: 'lwDxgZc8zPYPX0aGQFjs',
      size: 'M',
      name: 'Ruski',
    );
    await DogRepository().uploadDog(dog23);
    final dog24 = Dog(
      id: '24',
      age: 3,
      location: 'Valencia',
      breed: 'Border Collie',
      description: 'Border Collie inteligente y enérgico en busca de un dueño activo.',
      friendly: ['Personas', 'Perros'],
      notFriendly: ['Gatos'],
      gender: 'Macho',
      personality: ['Leal', 'Trabajador'],
      healthPositive: ['Vacunado', 'Desparasitado'],
      healthNegative: [],
      isReserved: false,
      mainPictureURL: 'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog25-1.jpg?alt=media&token=347915e1-c4e9-4611-9a58-b3f19f96287d&_gl=1*1xdug5m*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc2MDMuMC4wLjA.',
      pictureURLs: ["https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog25-1.jpg?alt=media&token=347915e1-c4e9-4611-9a58-b3f19f96287d&_gl=1*1xdug5m*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc2MDMuMC4wLjA.",
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog25-2.jpg?alt=media&token=c38df98d-5a83-482d-aa3f-e2d0be4b1a38&_gl=1*7l1u02*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc2MjcuMC4wLjA."
      ],
      shelterID: 'CcpvzKcfg2KPfdwxTLZz',
      size: 'M',
      name: 'Max',
    );
    await DogRepository().uploadDog(dog24);
    final dog25 = Dog(
      id: '25',
      age: 2,
      location: 'Sevilla',
      breed: 'Border Collie',
      description: 'Border Collie inteligente y cariñoso en busca de una familia activa.',
      friendly: ['Personas', 'Perros'],
      notFriendly: ['Gatos'],
      gender: 'Hembra',
      personality: ['Leal', 'Juguetón'],
      healthPositive: ['Vacunado', 'Desparasitado'],
      healthNegative: [],
      isReserved: false,
      mainPictureURL: 'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog26-1.jpg?alt=media&token=ee753dd5-d72d-409f-8f07-be6f85ae00df&_gl=1*1sugns0*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc2NDMuMC4wLjA.',
      pictureURLs: [
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog26-1.jpg?alt=media&token=ee753dd5-d72d-409f-8f07-be6f85ae00df&_gl=1*1sugns0*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc2NDMuMC4wLjA.",
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog26-2.jpg?alt=media&token=97f530ff-6fe8-4d1f-982b-d877883fac0b&_gl=1*emgrt7*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc2NjIuMC4wLjA."
      ],
      shelterID: 'l0nKmZYIJpsFoBv3mJBq',
      size: 'M',
      name: 'Molly',
    );
    await DogRepository().uploadDog(dog25);
    final dog26 = Dog(
      id: '26',
      age: 2,
      location: 'Barcelona',
      breed: 'Corgi',
      description: 'Corgi amigable y cariñoso en busca de un hogar acogedor.',
      friendly: ['Personas', 'Perros'],
      notFriendly: ['Gatos'],
      gender: 'Macho',
      personality: ['Leal', 'Alegre'],
      healthPositive: ['Vacunado', 'Esterilizado'],
      healthNegative: [],
      isReserved: false,
      mainPictureURL: 'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog27-1.jpg?alt=media&token=1fb427aa-813e-450d-a280-efa66883cad1&_gl=1*1gp4548*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc2NzYuMC4wLjA.',
      pictureURLs: [
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog27-1.jpg?alt=media&token=1fb427aa-813e-450d-a280-efa66883cad1&_gl=1*1gp4548*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc2NzYuMC4wLjA.",
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog27-2.jpg?alt=media&token=13f39a71-74be-44a2-951c-5077496612d8&_gl=1*1bq3wsx*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc2OTMuMC4wLjA."
      ],
      shelterID: 'l0nKmZYIJpsFoBv3mJBq',
      size: 'S',
      name: 'Charlie',
    );
    await DogRepository().uploadDog(dog26);
    final dog27 = Dog(
      id: '27',
      age: 1,
      location: 'Madrid',
      breed: 'Shiba Inu',
      description: 'Shiba Inu curioso y enérgico en busca de un hogar activo.',
      friendly: ['Personas', 'Perros'],
      notFriendly: ['Gatos'],
      gender: 'Hembra',
      personality: ['Independiente', 'Juguetón'],
      healthPositive: ['Vacunado', 'Desparasitado'],
      healthNegative: [],
      isReserved: false,
      mainPictureURL: 'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog28-1.jpg?alt=media&token=f7ad98ab-5eb3-4032-9650-85dd3fc79497&_gl=1*1554typ*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc3MTIuMC4wLjA.',
      pictureURLs: [
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog28-1.jpg?alt=media&token=f7ad98ab-5eb3-4032-9650-85dd3fc79497&_gl=1*1554typ*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc3MTIuMC4wLjA.",
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog28-2.jpg?alt=media&token=dee48d71-89ba-470f-abe2-b7f4b320ccdf&_gl=1*1a1mx52*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc3MjkuMC4wLjA."
      ],
      shelterID: 'l0nKmZYIJpsFoBv3mJBq',
      size: 'M',
      name: 'Kiki',
    );
    await DogRepository().uploadDog(dog27);
    final dog28 = Dog(
      id: '28',
      age: 2,
      location: 'Valencia',
      breed: 'Shiba Inu',
      description: 'Shiba Inu tranquilo y afectuoso en busca de una familia cariñosa.',
      friendly: ['Personas', 'Perros'],
      notFriendly: ['Gatos'],
      gender: 'Macho',
      personality: ['Leal', 'Calmado'],
      healthPositive: ['Vacunado', 'Esterilizado'],
      healthNegative: [],
      isReserved: false,
      mainPictureURL: 'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog29-1.jpg?alt=media&token=5d99635b-8871-46eb-ad03-393b35e4dbe1&_gl=1*vx83ap*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc5ODcuMC4wLjA.',
      pictureURLs: [
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog29-1.jpg?alt=media&token=5d99635b-8871-46eb-ad03-393b35e4dbe1&_gl=1*vx83ap*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjc5ODcuMC4wLjA.",
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog29-2.jpg?alt=media&token=b424b525-4602-4f0f-bcaf-2bc8ac6227a0&_gl=1*k5a4gx*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwMDkuMC4wLjA."
      ],
      shelterID: 'lwDxgZc8zPYPX0aGQFjs',
      size: 'M',
      name: 'Coco',
    );
    await DogRepository().uploadDog(dog28);
    final dog29 = Dog(
      id: '29',
      age: 2,
      location: 'Sevilla',
      breed: 'Husky',
      description: 'Husky activo y sociable en busca de una familia deportista.',
      friendly: ['Personas', 'Perros'],
      notFriendly: ['Gatos'],
      gender: 'Hembra',
      personality: ['Energético', 'Amigable'],
      healthPositive: ['Vacunado', 'Desparasitado'],
      healthNegative: [],
      isReserved: false,
      mainPictureURL: 'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog30-1.jpg?alt=media&token=37cb5d96-5bb1-4ab5-82ec-f28147e85303&_gl=1*1upp33p*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwMjYuMC4wLjA.',
      pictureURLs: ["https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog30-1.jpg?alt=media&token=37cb5d96-5bb1-4ab5-82ec-f28147e85303&_gl=1*1upp33p*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwMjYuMC4wLjA.",
      "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog30-2.jpg?alt=media&token=21e11885-ecd6-4161-8576-6fd6ea677732&_gl=1*1accfaf*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwNDQuMC4wLjA."
      ],
      shelterID: 'CcpvzKcfg2KPfdwxTLZz',
      size: 'L',
      name: 'Nala',
    );
    await DogRepository().uploadDog(dog29);
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
      mainPictureURL: 'https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog31-1.jpg?alt=media&token=e1cceaca-0b30-451a-bbe8-d5c43f4195db&_gl=1*wrzwil*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwNTkuMC4wLjA.',
      pictureURLs: [
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog31-1.jpg?alt=media&token=e1cceaca-0b30-451a-bbe8-d5c43f4195db&_gl=1*wrzwil*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwNTkuMC4wLjA.",
        "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/dog31-2.jpg?alt=media&token=a67c8bd9-d4e4-446b-9b20-2defa22930ff&_gl=1*58rc0q*_ga*MTc0OTUwMjE4Ny4xNjg1MjA5MjA1*_ga_CW55HF8NVT*MTY4NjA2MzM4NS4xNC4xLjE2ODYwNjgwODEuMC4wLjA."
      ],
      shelterID: 'l0nKmZYIJpsFoBv3mJBq',
      size: 'L',
      name: 'Menta',
    );


    // Upload the dog to Firebase Firestore
    await DogRepository().uploadDog(dog30);
  }

  void navigateToForgotPwd() {
    Get.toNamed(Routes.AUTH + Routes.FORGOT_PASSWORD, arguments: this);
  }
}
