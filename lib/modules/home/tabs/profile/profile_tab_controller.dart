import 'package:get/get.dart';
import 'package:hundopt/shared/services/data_managers/dog_manager.dart';
import '../../../../api/firebase_core/firebase_core.dart';
import '../../../../models/model.dart';
import '../../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  RxString username = RxString('');
  RxString fullName = RxString('');
  late Rx<HundoptUser> user = HundoptUser.empty().obs;
  RxList userAdoptingDogs = [].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    user.value = (await Auth().retrieveUser())!;
    setScreenValues();
    update();
  }



  void setScreenValues() async {
    user.value = (await Auth().forceRetrieveUser())!;
    username.value = '@${user.value.username}';
    fullName.value = user.value.fullName;
    userAdoptingDogs
        .assignAll(await DogRepository().fetchAdoptingDogs(user.value));
    update();
  }

  Future<void> updateValues() async {
    user.value = (await Auth().forceRetrieveUser())!;
    final updatedDogs = await DogRepository().fetchAdoptingDogs(user.value);
    userAdoptingDogs.assignAll(updatedDogs);
    update();
  }

  void onSettingsPressed() {
    Get.toNamed(Routes.SETTINGS, arguments: this);
  }

  navigateToDogInfo(Dog dog) {
    DogManager().setCurrentDog(dog);
    Get.offNamed(Routes.DOG_INFO);
  }
}
