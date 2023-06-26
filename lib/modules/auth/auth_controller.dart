import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/firebase_core.dart';
import 'package:hundopt/modules/home/home.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';
import '../../shared/services/data_managers/singletons/user_singleton.dart';
import '../../shared/shared.dart';

/// The [AuthController] class handles user authentication and form field validation.
class AuthController extends GetxController {
  final userManager = UserSingleton();

  /// The error message for the first email field.
  RxnString fEmailErrText = RxnString(null);

  /// The error message for the second email field.
  RxnString rEmailErrText = RxnString(null);

  /// The error message for the username field.
  RxnString rUsernameErrText = RxnString("");

  /// The error message for the password field.
  RxnString rPwdErrText = RxnString(null);

  /// The error message for the login email field.
  RxnString lEmailErrText = RxnString(null);

  /// The error message for the login password field.
  RxnString lPwdErrText = RxnString(null);

  /// The first email field.
  RxString fEmail = RxString('');

  /// The second email field.
  RxString rEmail = RxString('');

  /// The username field.
  RxString rUsername = RxString('');

  /// The password field.
  RxString rPwd = RxString('');

  /// The login email field.
  RxString lEmail = RxString('');

  /// The login password field.
  RxString lPwd = RxString('');

  /// The function to be called when the submit button is pressed.
  Rxn<Function()> submitFunc = Rxn<Function()>(() => {});

  /// The onInit method is called when the AuthController is initialized.
  /// It calls the initFormFieldValidators method to initialize the form field validators.
  @override
  void onInit() {
    super.onInit();
    initFormFieldValidators();
  }

  /// Initializes the form field validators.
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

  /// Validates the forgot password email field.
  ///
  /// The [val] parameter is the value of the first email field.
  /// The [fEmailErrText] parameter is a reactive string that holds the error message for the first email field.
  ///
  /// This method resets the validation errors to nothing and disables the submit button while validating.
  /// If the [val] is not empty, it calls the [isValidEmail] method from the [Validations] class to check if the email is valid.
  /// If the email is valid, it sets the submit function to call the [sendResetPwdEmail] method and sets the error message to an empty string.
  /// If the email is not valid, it sets the error message to "Formato de email no válido." and returns false.
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

  /// Validates the login email field.
  ///
  /// The [val] parameter is the value of the login email field.
  /// The [lEmailErrText] parameter is a reactive string that holds the error message for the login email field.
  ///
  /// This method resets the validation errors to nothing and disables the submit button while validating.
  /// If the [val] is not empty, it calls the [isValidEmail] method from the [Validations] class to check if the email is valid.
  /// If the email is valid, it sets the submit function to an empty function and sets the error message to an empty string.
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

  /// Validates the login password field.
  ///
  /// The [val] parameter is the value of the login password field.
  /// The [lPwdErrText] parameter is a reactive string that holds the error message for the login password field.
  ///
  /// This method resets the validation errors to nothing and disables the submit button while validating.
  /// If the [val] is not empty, it calls the [lengthOK] and [isValidPassword] methods from the [Validations] class to check if the password is valid.
  /// If the password is valid, it sets the submit function to an empty function and sets the error message to an empty string.
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

  /// Validates the register email field.
  ///
  /// The [val] parameter is the value of the second email field.
  /// The [rEmailErrText] parameter is a reactive string that holds the error message for the second email field.
  ///
  /// This method resets the validation errors to nothing and disables the submit button while validating.
  /// If the [val] is not empty, it calls the [isValidEmail] method from the [Validations] class to check if the email is valid.
  /// If the email is valid, it sets the submit function to an empty function and sets the error message to an empty string.
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

  /// Validates the register username field.
  ///
  /// The [val] parameter is the value of the username field.
  /// The [rUsernameErrText] parameter is a reactive string that holds the error message for the username field.
  ///
  /// This method resets the validation errors to nothing and disables the submit button while validating.
  /// If the [val] is not empty, it calls the [isValidUsername] and [lengthOK] methods from the [Validations] class to check if the username is valid.
  /// If the username is valid, it sets the submit function to an empty function and sets the error message to an empty string.
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

  /// Validates the register password field.
  ///
  /// The [val] parameter is the value of the password field.
  /// The [rPwdErrText] parameter is a reactive string that holds the error message for the password field.
  ///
  /// This method resets the validation errors to nothing and disables the submit button while validating.
  /// If the [val] is not empty, it calls the [isValidPassword] and [lengthOK] methods from the [Validations] class to check if the password is valid.
  /// If the password is valid, it sets the submit function to an empty function and sets the error message to an empty string.
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

  /// Updates the value of the forgot password email field.
  ///
  /// The [val] parameter is the new value of the first email field.
  void fEmailChanged(String val) {
    fEmail.value = val;
  }

  /// Updates the value of the login email field.
  ///
  /// The [val] parameter is the new value of the login email field.
  void lEmailChanged(String val) {
    lEmail.value = val;
  }

  /// Updates the value of the register email field.
  ///
  /// The [val] parameter is the new value of the second email field.
  void rEmailChanged(String val) {
    rEmail.value = val;
  }

  /// Updates the value of the register username field.
  ///
  /// The [val] parameter is the new value of the username field.
  void rUsernameChanged(String val) {
    rUsername.value = val;
  }

  /// Updates the value of the login password field.
  ///
  /// The [val] parameter is the new value of the login password field.
  void lPwdChanged(String val) {
    lPwd.value = val;
  }

  /// Updates the value of the register password field.
  ///
  /// The [val] parameter is the new value of the password field.
  void rPwdChanged(String val) {
    rPwd.value = val;
  }

  /// Triggers the Firebase Authentication backend to send a password reset email to the given email address.
  ///
  /// This method shows a loading indicator while the email is being sent.
  /// If the email is sent successfully, it shows a dialog with a success message and a button to navigate to the login screen.
  /// If there is an error sending the email, it sets the error message to the `fEmailErrText` reactive string.
  void sendResetPwdEmail() async {
    try {
      EasyLoading.show(status: StringConstants.loadingLabel);
      await sendPasswordResetEmail();
    } finally {
      EasyLoading.dismiss();
    }
  }

  /// Sends a password reset email to the email address in the first email field.
  ///
  /// This method shows a dialog with a success message and a button to navigate to the login screen if the email is sent successfully.
  /// If there is an error sending the email, it sets the error message to the `fEmailErrText` reactive string.
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
      fEmailErrText.value = e.message;
    }
  }

  /// Sets the current tab of the HomeController to the explore tab
  void setInitialHomeTab(){
    final ProfileController profileController = Get.find<ProfileController>();
    profileController.setScreenValues();
  }

  /// Triggers the Firebase Authentication backend to sign in a user with the given email address and password.
  ///
  /// This method shows a loading indicator while the user is being signed in. If sign in is successful, it sets the current user and navigates to the home screen.
  /// If there is an error signing in, it sets the error message to the `lPwdErrText` reactive string.
  Future<void> login() async {
    try {
      EasyLoading.show(status: StringConstants.loadingLabel);
      await signInWithEmailAndPassword();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        HundoptUser hundoptUser = await UserRepository().getUser(user.uid);
        UserManager().setUser(hundoptUser);
        setInitialHomeTab();
        Get.toNamed(Routes.HOME, arguments: 0);
      }
    } finally {
      EasyLoading.dismiss();
      lEmail.value = "";
      lPwd.value = "";
    }
  }

  /// Triggers the Firebase Authentication backend to create a new user with the given email address and password.
  ///
  /// This method shows a loading indicator while the user is being created.
  /// If user creation is successful, it sets the current user and navigates to the onboarding screen.
  /// If there is an error creating the user, it sets the error message to the `lPwdErrText` reactive string.
  void register() async {
    try {
      EasyLoading.show(status: StringConstants.loadingLabel);
      await createUserWithEmailAndPassword();
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        await UserRepository().createUser(
            rUsername.value, firebaseUser.email!, firebaseUser.uid, "");
        UserManager().setUser(HundoptUser.withEmailAndUsername(
            email: firebaseUser.email!, username: rUsername.value));
        Get.toNamed(Routes.ONBOARDING);
      }
    } finally {
      EasyLoading.dismiss();
      rEmail.value = "";
      rUsername.value = "";
      rPwd.value = "";
    }
  }

  /// Triggers the Firebase Authentication backend to create a new user with the given email address and password.
  ///
  /// This method sets the error message to the `lPwdErrText` reactive string if there is an error creating the user.
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

  /// Triggers the Firebase Authentication backend to sign in a user with the given email address and password.
  ///
  /// This method sets the error message to the `lPwdErrText` reactive string if there is an error signing in.
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

  /// Navigates to the login screen.
  ///
  /// This method uses the Get package to navigate to the login screen.
  void navigateToLogin() {
    Get.offAndToNamed(Routes.AUTH + Routes.LOGIN, arguments: this);
  }

  /// Navigates to the register screen.
  ///
  /// This method uses the Get package to navigate to the login screen.
  void navigateToRegister() {
    Get.toNamed(Routes.AUTH + Routes.REGISTER, arguments: this);
  }

  /// Navigates to the forgot password screen.
  ///
  /// This method uses the Get package to navigate to the login screen.
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
