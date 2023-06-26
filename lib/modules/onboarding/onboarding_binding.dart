import 'package:get/get.dart';
import 'onboarding.dart';

/// The [OnboardingBinding] class representing the bindings for the individual chat screen of the Hundopt app.
///
/// This class sets up the dependencies for the [OnboardingController] class using the `Get.lazyPut` method.
class OnboardingBinding extends Bindings {
  /// Sets up the dependencies for the [OnboardingBinding] class.
  ///
  /// This method uses the `Get.lazyPut` method to set up the [OnboardingController] class.
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
  }
}
