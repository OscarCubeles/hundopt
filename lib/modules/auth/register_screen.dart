import 'package:flutter/material.dart';
import 'package:hundopt/modules/auth/auth.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: _buildForms(context),
          ),
        ),
        Text("Register")
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
