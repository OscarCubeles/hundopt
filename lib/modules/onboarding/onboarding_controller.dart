import 'package:get/get.dart';
import '../../routes/app_pages.dart';

/// The [OnboardingController] manages all actions for the onboarding screen
/// showed when a user logs in or regesters to the app
class OnboardingController extends GetxController {
  /// Navigates to the Personality Form screen.
  void navigateToForm() {
    Get.toNamed(Routes.PERSONALITY_FORM, arguments: this);
  }

  /// Navigates to the Explore screen.
  void navigateToExplore() {
    Get.toNamed(Routes.HOME, arguments: 0);
  }
}
