import 'package:get/get.dart';
import 'splash_controller.dart';

/// The [SplashBinding] class representing the bindings for the initial splash screen showed in Hundopt app.
///
/// This class sets up the dependencies for the [SplashController] class using the `Get.lazyPut` method.
class SplashBinding extends Bindings {
  /// Sets up the dependencies for the [SplashBinding] class.
  ///
  /// This method uses the `Get.lazyPut` method to set up the [SplashController] class.
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
