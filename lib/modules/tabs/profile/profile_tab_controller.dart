import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/user_repository.dart';
import 'package:hundopt/shared/services/user_singleton.dart';

import '../../../api/firebase_core/auth.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  RxString username = RxString('');
  RxString fullName = RxString('');
  late HundoptUser user = HundoptUser.empty();

  @override
  Future<void> onInit() async {
    super.onInit();
    user = (await Auth().retrieveUser())!;
    setScreenValues(user);
  }

  void setScreenValues(HundoptUser? user) {
    username.value = '@${user?.username}';
    fullName.value = "${user?.fullName}";
    // TODO: Change the dogs
    update();
  }

  void onSettingsPressed() {
    Get.offNamed(Routes.SETTINGS, arguments: this);
  }
}
