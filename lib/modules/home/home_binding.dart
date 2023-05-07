//home_binding.dart

import 'package:hundopt/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/shelter_profile/shelter_profile.dart';
import 'package:hundopt/modules/tabs/chat/chat_tab_controller.dart';
import 'package:hundopt/modules/tabs/explore/explore_tab_controller.dart';
import 'package:hundopt/modules/tabs/favourite/favourite_tab_controller.dart';
import 'package:hundopt/modules/tabs/profile/profile_tab_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => FavouriteController());
    Get.lazyPut(() => ExploreController());
    Get.lazyPut(() => ShelterProfileController());
  }
}