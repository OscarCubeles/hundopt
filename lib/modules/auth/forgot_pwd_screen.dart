import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/shared.dart';
import 'auth_controller.dart';

/// The [ForgotPassword] class representing the forgot password screen of the Hundopt app.
///
/// This class displays the forgot password screen, which allows users to reset
/// their password by entering their email address.
/// The screen contains a text field for entering the email address,
/// a button for submitting the email address, and a clickable text for returning to the login screen.
class ForgotPassword extends StatelessWidget {
  /// The authentication controller for the screen.
  final AuthController controller = Get.arguments;

  /// Constructs a new instance of the [ForgotPassword] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  ForgotPassword({super.key});

  /// Builds the widget tree for the forgot password screen.
  ///
  /// This method returns a [Scaffold] widget containing a [MainAppBar] widget
  /// and a [SingleChildScrollView] widget with a [Column] widget containing a
  /// text field for entering the email address,a button for submitting the email
  /// address, and a clickable text for returning to the login screen.
  @override
  Widget build(BuildContext context) {
    AuthController fx = Get.put(AuthController()); // controller
    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: ColorConstants.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringConstants.recuperatePwdText,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    child: Text(
                      StringConstants.infoRecuperatePwdText,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Obx(() {
                    return CustomTextField(
                        isPassword: false,
                        labelText: StringConstants.emailLabel,
                        errorText: fx.fEmailErrText.value ?? "",
                        initialValue: "",
                        onChanged: fx.fEmailChanged);
                  }),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.24)),
                  Obx(() => AppPrimaryButton(
                        text: StringConstants.sendEmailLabel,
                        onPressed: fx.submitFunc.value!,
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
                  ClickableText(
                      uText: StringConstants.backLabel,
                      text: StringConstants.noRecuperatePwdText,
                      onPressed: () => controller.navigateToLogin()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
