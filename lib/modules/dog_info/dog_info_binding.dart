import 'package:hundopt/modules/dog_info/dog_info_controller.dart';
import 'package:get/get.dart';

class DogInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DogInfoController());
  }
}