import 'package:firebase_auth/firebase_auth.dart';
import 'package:hundopt/routes/routes.dart';
import 'package:get/get.dart';

/// The [SplashController] class is used to redirect the user to the Home screen
/// or the Auth sceen depending if the user is logged in or not
class SplashController extends GetxController {
  /// If the user is logged in, it redirects the user to the Home screen.
  /// If not, it redirects it to the base auth screen.
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
