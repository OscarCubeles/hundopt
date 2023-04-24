import 'package:flutter/material.dart';
import 'package:hundopt/modules/auth/auth.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/shared.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    StringConstants.crearCuenta,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.left,
                  ),
                  const CustomTextField(labelText: StringConstants.nombreUsuario),
                  Padding(padding: EdgeInsets.all(10)),
                  const CustomTextField(labelText: StringConstants.email),
                  Padding(padding: EdgeInsets.all(10)),
                  const CustomTextField(labelText: StringConstants.password),
                  AppPrimaryButton(
                      text: StringConstants.crearCuenta,
                      onPressed: () => {
                        Get.toNamed(Routes.AUTH + Routes.REGISTER,
                            arguments: controller)
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForms(BuildContext context) {
    return Form(

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          ],
        ),
      ),
    );
  }
}
