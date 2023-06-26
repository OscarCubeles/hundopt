import 'package:get/get.dart';
import 'settings_controller.dart';

/// The [SettingsBinding] class representing the bindings for the settings screen of the Hundopt app.
///
/// This class sets up the dependencies for the [SettingsController] class using the `Get.lazyPut` method.
class SettingsBinding extends Bindings {
  /// Sets up the dependencies for the [SettingsBinding] class.
  ///
  /// This method uses the `Get.lazyPut` method to set up the [SettingsController] class.
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController());
  }
}
