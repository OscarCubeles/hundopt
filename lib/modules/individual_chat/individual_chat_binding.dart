import 'package:get/get.dart';
import 'package:hundopt/modules/individual_chat/individual_chat_controller.dart';

/// The [IndividualChatBinding] class representing the bindings for the individual chat screen of the Hundopt app.
///
/// This class sets up the dependencies for the [IndividualChatController] class using the `Get.lazyPut` method.
class IndividualChatBinding extends Bindings {
  /// Sets up the dependencies for the [IndividualChatBinding] class.
  ///
  /// This method uses the `Get.lazyPut` method to set up the [IndividualChatController] class.
  @override
  void dependencies() {
    Get.lazyPut(() => IndividualChatController());
  }
}
