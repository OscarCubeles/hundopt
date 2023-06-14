import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/dog_repository.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';

import '../../../api/firebase_core/auth.dart';
import '../../../api/firebase_core/shelter_repository.dart';
import '../../../api/firebase_core/user_repository.dart';
import '../../../models/dog.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/services/shelter_singleton.dart';

class ExploreController extends GetxController {
  final Rx<List<Dog>> _dogList = Rx<List<Dog>>([]);
  late HundoptUser user = HundoptUser.empty();
  int dogIndex = 0;

  List<Dog> get dogList => _dogList.value;

  @override
  void onInit() async {
    super.onInit();
    user = (await Auth().retrieveUser())!;
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
    _dogList.value = DogSingleton().dogs!;
    if (ShelterSingleton().shelters == []) {
      await ShelterRepository().retrieveShelters();
    }
    retrieveShelter();
  }

  int initialPage() {
    return DogSingleton().dogIndex == null
        ? dogIndex
        : DogSingleton().dogIndex!;
  }

  void retrieveShelter() {
    for (int i = 0; i < ShelterSingleton().shelters.length; i++) {
      if (ShelterSingleton().shelters[i].id ==
          DogSingleton().dogs![DogSingleton().dogIndex!].shelterID) {
        ShelterSingleton().shelterIndex = i;
        return;
      }
    }
  }

  // TODO: Add this as a service
  void toggleLikeStatus(String dogId) {
    if (isDogLiked(dogId)) {
      dislikeDog(dogId);
      return;
    }
    likeDog(dogId);
  }

  // TODO: Put this as a service
  void dislikeDog(String dogId) async {
    await UserRepository().removeFavDog(user.id, dogId);
    user.favDogs.remove(dogId);
  }

  // TODO: Put this as a service
  void likeDog(String dogId) async {
    await UserRepository().addFavDog(user.id, dogId);
    user.favDogs.add(dogId);
  }

  // TODO: Put this as a service
  bool isDogLiked(String dogId) {
    for (int i = 0; i < user.favDogs.length; i++) {
      if (dogId == user.favDogs[i]) {
        return true;
      }
    }
    return false;
  }

  void navigateToDogInfo(int index) {
    DogSingleton().dogIndex = index;
    retrieveShelter();
    Get.offNamed(Routes.DOG_INFO, arguments: dogList[index]);
  }
}
