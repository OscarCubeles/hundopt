import 'package:hundopt/routes/routes.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      //Check if the user has been authenticated before, if not, make it log in
      var storage = Get.find<SharedPreferences>();
      if (storage.getString(StorageConstants.token) != null) {
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.AUTH);
      }
    } catch (e) {
      Get.toNamed(Routes.AUTH);
    }
  }
}
