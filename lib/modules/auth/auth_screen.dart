import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/widgets.dart';
import 'auth_controller.dart';

/// The [AuthScreen] class representing the authentication screen of the Hundopt app.
///
/// This class displays the authentication screen, which allows users to either
/// create an account or log in to an existing account. The screen contains an
/// app logo, the name of the app, and two buttons for creating an account or logging in.
class AuthScreen extends GetView<AuthController> {
  /// Constructs a new instance of the [AuthScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const AuthScreen({super.key});

  /// Builds the widget tree for the authentication screen.
  ///
  /// This method returns a [SingleChildScrollView] widget containing a [Column] widget with the app logo,
  /// the name of the app, and two buttons for creating an account or logging in.
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            color: ColorConstants.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * 0.1, 0, 0)),
                Image.asset(
                  AssetsPath.appLogo,
                  fit: BoxFit.contain,
                  height: 300,
                ),
                Text(
                  StringConstants.appName,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05),
                  child: Text(
                    StringConstants.authText,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                AppPrimaryButton(
                    text: StringConstants.createAccountLabel,
                    onPressed: () => {
                          Get.toNamed(Routes.AUTH + Routes.REGISTER,
                              arguments: controller)
                        }),
                const ButtonPadding(),
                AppSecondaryButton(
                    text: StringConstants.loginLabel,
                    onPressed: () => {
                          Get.toNamed(Routes.AUTH + Routes.LOGIN,
                              arguments: controller)
                        })
              ],
            ),
          )
        ],
      ),
    );
  }
}
