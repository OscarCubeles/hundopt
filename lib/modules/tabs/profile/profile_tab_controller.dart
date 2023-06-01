import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/constants/constants.dart';
import 'package:intl/intl.dart';

import '../../../models/chat.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {

  late String username;
  late String fullName;

  @override
  void onInit() {
    super.onInit();
    final user = FirebaseAuth.instance.currentUser;

    username = "@";
    fullName = "Oscar Cubeles";

  }

  void onSettingsPressed(){
    Get.offNamed(Routes.SETTINGS, arguments: this);
  }

}
