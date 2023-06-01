import 'package:firebase_auth/firebase_auth.dart';
import 'package:hundopt/routes/routes.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {


  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: Change this code to check if the user is auth in Firebase or not
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user != null) {
        // User is authenticated with Firebase
        Get.toNamed(Routes.HOME, arguments: 0);
      } else {
        // User is not authenticated with Firebase
        Get.toNamed(Routes.AUTH);
      }
    });
  }
}
