import 'package:flutter/material.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      ],
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
