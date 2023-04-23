import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/widgets.dart';
import 'auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

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
                    StringConstants.authMsg,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                AppPrimaryButton(
                    text: StringConstants.crearCuenta,
                    onPressed: () => {
                          Get.toNamed(Routes.AUTH + Routes.REGISTER,
                              arguments: controller)
                        }),
                const ButtonPadding(),
                AppSecondaryButton(
                    text: StringConstants.iniciarSession, onPressed: () => {
                  Get.toNamed(Routes.AUTH + Routes.LOGIN,
                      arguments: controller)
                })
                // TODO: ADD ONPRESSED
              ],
            ),
          )
        ],
      ),
    );
  }
}
