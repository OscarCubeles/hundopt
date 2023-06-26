import 'package:flutter/material.dart';
import 'package:hundopt/modules/auth/auth.dart';
import 'package:get/get.dart';
import '../../shared/shared.dart';

/// The [RegisterScreen] class representing the register screen of the Hundopt app.
///
/// This class displays the register screen, which allows users to create a
/// new account by entering their username, email address, and password.
/// The screen contains three text fields for entering the username, email address,
/// and password, a button for submitting the registration information,
/// and a clickable text for returning to the login screen.
class RegisterScreen extends StatelessWidget {
  /// The authentication controller for the screen.
  final AuthController controller = Get.arguments;

  /// Constructs a new instance of the [RegisterScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  RegisterScreen({super.key});

  /// Builds the widget tree for the register screen.
  ///
  /// This method returns an [AppScaffold] widget containing a [Column] widget
  /// with three text fields for entering the username, email address, and password,
  /// a button for submitting the registration information, and a clickable text
  /// for returning to the login screen.
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              StringConstants.createAccountText,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.start,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, MediaQuery.of(context).size.height * 0.05)),
            Obx(() => CustomTextField(
                  isPassword: false,
                  labelText: StringConstants.usernameLabel,
                  errorText: controller.rUsernameErrText.value ?? "",
                  onChanged: controller.rUsernameChanged,
                  initialValue: controller.rUsername.value,
                )),
            Obx(
              () => CustomTextField(
                isPassword: false,
                labelText: StringConstants.emailLabel,
                errorText: controller.rEmailErrText.value ?? "",
                onChanged: controller.rEmailChanged,
                initialValue: controller.rEmail.value,
              ),
            ),
            Obx(() => CustomTextField(
                  isPassword: true,
                  labelText: StringConstants.passwordLabel,
                  errorText: controller.rPwdErrText.value ?? "",
                  onChanged: controller.rPwdChanged,
                  initialValue: controller.rPwd.value,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, MediaQuery.of(context).size.height * 0.155)),
            AppPrimaryButton(
                text: StringConstants.createAccountLabel,
                onPressed: () => controller.register()),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
            ClickableText(
                uText: StringConstants.loginLabel,
                text: StringConstants.yesAccountText,
                onPressed: () => controller.navigateToLogin()),
          ],
        ));
  }
}
