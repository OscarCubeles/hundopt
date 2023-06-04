//home_binding.dart

import 'package:hundopt/modules/dog_info/dog_info_controller.dart';
import 'package:hundopt/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/tabs/chat/chat_tab_controller.dart';
import 'package:hundopt/modules/tabs/explore/explore_tab_controller.dart';
import 'package:hundopt/modules/tabs/favourite/favourite_tab_controller.dart';
import 'package:hundopt/modules/tabs/profile/profile_tab_controller.dart';

class DogInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DogInfoController());
  }
}