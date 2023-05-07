import 'package:get/get.dart';
import 'package:hundopt/modules/shelter_profile/shelter_profile.dart';


class ShelterProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ShelterProfileController());
  }

}