import 'package:get/get.dart';
import 'package:hundopt/shared/services/data_managers/dog_manager.dart';
import '../../../../api/firebase_core/firebase_core.dart';
import '../../../../models/model.dart';
import '../../../../routes/app_pages.dart';

/// The [ProfileController] class manages all data and actions of the [ProfileTab] screen
class ProfileController extends GetxController {
  /// A reactive string representing the username.
  RxString username = RxString('');

  /// A reactive string representing the full name.
  RxString fullName = RxString('');

  /// A reactive user.
  late Rx<HundoptUser> user = HundoptUser.empty().obs;

  /// A reactive list of dogs the user is adopting.
  RxList userAdoptingDogs = [].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    user.value = (await Auth().retrieveUser())!;
    setScreenValues();
    update();
  }

  /// Updates the screen values with the username, user fullename and user reserved dogs.
  void setScreenValues() async {
    user.value = (await Auth().forceRetrieveUser())!;
    username.value = '@${user.value.username}';
    fullName.value = user.value.fullName;
    userAdoptingDogs
        .assignAll(await DogRepository().fetchAdoptingDogs(user.value));
    update();
  }

  /// Updates the user data and the list of dogs the user is adopting.
  Future<void> updateValues() async {
    user.value = (await Auth().forceRetrieveUser())!;
    final updatedDogs = await DogRepository().fetchAdoptingDogs(user.value);
    userAdoptingDogs.assignAll(updatedDogs);
    update();
  }

  /// Navigates to the settings screen.
  void onSettingsPressed() {
    Get.toNamed(Routes.SETTINGS, arguments: this);
  }

  /// Navigates to the dog info screen.
  ///
  /// The [dog] parameter is the dog to navigate to the info screen.
  /// It sets the current dog using the `DogManager` class and navigates to the info screen using the `Get` package.
  void navigateToDogInfo(Dog dog) {
    DogManager().setCurrentDog(dog);
    Get.offNamed(Routes.DOG_INFO);
  }
}
