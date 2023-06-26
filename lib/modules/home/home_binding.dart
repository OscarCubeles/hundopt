import 'package:hundopt/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:hundopt/modules/shelter_profile/shelter_profile.dart';

/// The [HomeBinding] class representing the bindings for the home screen of the Hundopt app.
///
/// This class sets up the dependencies for the [DogInfoController] class using the `Get.lazyPut` method.
class HomeBinding extends Bindings {
  /// Sets up the dependencies for the [HomeBinding] class.
  ///
  /// This method uses the `Get.lazyPut` method to set up the [HomeController] class.
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
