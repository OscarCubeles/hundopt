import 'package:flutter/material.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

/// The [LoginScreen] class represents the login screen of the Hundopt app.
///
/// This class displays the login screen, which allows users to log in to their
/// account by entering their email address and password.
/// The screen contains two text fields for entering the email address and password,
/// a button for submitting the login information, a clickable text for resetting the password,
/// and a clickable text for creating a new account.
class LoginScreen extends StatelessWidget {
  /// The authentication controller for the screen.
  final AuthController controller = Get.arguments;

  /// Constructs a new instance of the [LoginScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  LoginScreen({super.key});

  /// Builds the widget tree for the login screen.
  ///
  /// This method returns an [AppScaffold] widget containing a [Form] widget
  /// with a [Column] widget containing two text fields for entering the email address
  /// and password, a button for submitting the login information, a clickable
  /// text for resetting the password, and a clickable text for creating a new account.
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                StringConstants.loginLabel,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.left,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height * 0.05)),
              Obx(() {
                return CustomTextField(
                  isPassword: false,
                  labelText: StringConstants.emailLabel,
                  errorText: controller.lEmailErrText.value ?? "",
                  onChanged: controller.lEmailChanged,
                  initialValue: controller.lEmail.value,
                );
              }),
              Obx(() {
                return CustomTextField(
                  isPassword: true,
                  labelText: StringConstants.passwordLabel,
                  errorText: controller.lPwdErrText.value ?? "",
                  onChanged: controller.lPwdChanged,
                  initialValue: controller.lPwd.value,
                );
              }),
              const Padding(padding: EdgeInsets.all(5)),
              ClickableText(
                  uText: StringConstants.recuperateLabel,
                  text: StringConstants.forgotPwdText,
                  onPressed: () => controller.navigateToForgotPwd()),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height * 0.23)),
              AppPrimaryButton(
                  text: StringConstants.loginLabel,
                  onPressed: () => controller.login()),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
              ClickableText(
                  uText: StringConstants.createAccountLabel,
                  text: StringConstants.noAccountText,
                  onPressed: () => controller.navigateToRegister())
            ],
          ),
        ));
  }
}
