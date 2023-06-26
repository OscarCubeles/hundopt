import 'package:get/get.dart';
import 'package:hundopt/modules/auth/auth_controller.dart';

/// [AuthBinding] class  defines the dependencies for the authentication controller.
///
/// This class extends the [Bindings] class from the Get package and overrides its [dependencies]
/// method to define the dependencies for the authentication controller.
class AuthBinding extends Bindings {
  /// Overrides the [dependencies] method from the [Bindings] class to define the dependencies for the authentication controller.
  ///
  /// This method uses the [Get.lazyPut] method from the Get package to lazily initialize an instance of the [AuthController] class.
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
