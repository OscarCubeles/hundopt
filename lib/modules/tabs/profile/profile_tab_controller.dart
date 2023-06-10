import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/user_repository.dart';
import 'package:hundopt/shared/services/user_singleton.dart';

import '../../../api/firebase_core/auth.dart';
import '../../../api/firebase_core/dog_repository.dart';
import '../../../models/dog.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/services/dog_singleton.dart';

class ProfileController extends GetxController {
  RxString username = RxString('');
  RxString fullName = RxString('');
  late HundoptUser user = HundoptUser.empty();
  RxList userAdoptingDogs = [].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    user = (await Auth().retrieveUser())!;
    setScreenValues();

    update();
  }

  void setScreenValues() async {
    username.value = '@${user.username}';
    fullName.value = user.fullName;
    userAdoptingDogs.assignAll(await DogRepository().fetchAdoptingDogs(user));
    update();
  }

  void onSettingsPressed() {
    Get.offNamed(Routes.SETTINGS, arguments: this);
  }

  navigateToDogInfo(Dog dog) {
    print("${dog.name}");
    // TODO: Add this method in the service that uses the singleton, the service could be called dogmanager
    int i = 0;
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (dog.id == tmpDog.id) {
        DogSingleton().dogIndex = i;
        Get.offNamed(Routes.DOG_INFO, arguments: tmpDog);
        break;
      }
      i++;
    }
  }
}
