import 'package:get/get.dart';
import 'package:hundopt/modules/shelter_profile/shelter_profile.dart';

/// The [ShelterProfileBinding] class representing the bindings for the shelter screen of the Hundopt app.
///
/// This class sets up the dependencies for the [ShelterProfileController] class using the `Get.lazyPut` method.
class ShelterProfileBinding extends Bindings {
  /// Sets up the dependencies for the [ShelterProfileBinding] class.
  ///
  /// This method uses the `Get.lazyPut` method to set up the [ShelterProfileController] class.
  @override
  void dependencies() {
    Get.lazyPut(() => ShelterProfileController());
  }
}
