import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/constants/constants.dart';
import 'package:intl/intl.dart';

import '../../../models/chat.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {


  @override
  void onInit() {
    super.onInit();

  }

  void onSettingsPressed(){
    Get.toNamed(Routes.SETTINGS, arguments: this);
  }

}
