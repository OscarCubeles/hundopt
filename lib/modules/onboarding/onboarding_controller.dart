import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class OnboardingController extends GetxController{
  void navigateToForm() {
    Get.toNamed(Routes.PERSONALITY_FORM, arguments: this);
  }
  void navigateToExplore(){
    Get.toNamed(Routes.HOME, arguments: 0);
  }
}