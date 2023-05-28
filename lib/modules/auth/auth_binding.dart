//home_binding.dart

import 'package:get/get.dart';
import 'package:hundopt/modules/auth/auth_controller.dart';

import '../../api/api_provider.dart';
import '../../api/api_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.put(ApiProvider(), permanent: true); // TODO Change this two lines if not used
    Get.put(ApiRepository(apiProvider: Get.find()), permanent: true);
  }
}