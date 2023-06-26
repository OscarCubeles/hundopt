import 'package:hundopt/modules/dog_info/dog_info_controller.dart';
import 'package:get/get.dart';

/// The [DogInfoBinding] class representing the bindings for the dog info screen of the Hundopt app.
///
/// This class sets up the dependencies for the [DogInfoController] class using the `Get.lazyPut` method.
class DogInfoBinding extends Bindings {
  /// Sets up the dependencies for the [DogInfoController] class.
  ///
  /// This method uses the `Get.lazyPut` method to set up the [DogInfoController] class.
  @override
  void dependencies() {
    Get.lazyPut(() => DogInfoController());
  }
}
