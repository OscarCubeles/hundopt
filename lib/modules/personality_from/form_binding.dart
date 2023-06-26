import 'package:get/get.dart';
import 'form_controller.dart';

/// The [FormBinding] class representing the bindings for the personality form screen of the Hundopt app.
///
/// This class sets up the dependencies for the [FormController] class using the `Get.lazyPut` method.
class FormBinding extends Bindings {
  /// Sets up the dependencies for the [FormBinding] class.
  ///
  /// This method uses the `Get.lazyPut` method to set up the [FormController] class.
  @override
  void dependencies() {
    Get.lazyPut(() => FormController());
  }
}
