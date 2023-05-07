import 'package:get/get.dart';
import 'package:hundopt/modules/individual_chat/individual_chat_controller.dart';


class IndividualChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndividualChatController());
  }
}