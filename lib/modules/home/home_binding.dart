import 'package:hundopt/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:hundopt/modules/shelter_profile/shelter_profile.dart';

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