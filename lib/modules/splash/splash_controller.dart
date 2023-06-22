import 'package:firebase_auth/firebase_auth.dart';
import 'package:hundopt/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(milliseconds: 500));
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user != null) {
        Get.toNamed(Routes.HOME, arguments: 0);
      } else {
        Get.toNamed(Routes.AUTH);
      }
    });
  }
}
