import 'package:get/get.dart';
import 'package:hundopt/modules/shelter_profile/shelter_profile.dart';

import '../home/home_controller.dart';

class ShelterProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ShelterProfileController());
  }

}