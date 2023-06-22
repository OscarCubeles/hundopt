import 'dart:async';
import 'package:get/get.dart';
import '../../../../api/firebase_core/firebase_core.dart';
import '../../../../models/model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/services/services.dart';

class ExploreController extends GetxController {
  final Rx<List<Dog>> _dogList = Rx<List<Dog>>([]);
  late Rx<HundoptUser> user = HundoptUser.empty().obs;
  int dogIndex = 0;
  List<Dog> get dogList => _dogList.value;

  @override
  void onInit() async {
    super.onInit();
    user.value = (await Auth().retrieveUser())!;
    await DogManager().retrieveDogs();
    await ShelterManager().retrieveShelters();
    _dogList.value = DogManager().getDogs();
    Timer.periodic(const Duration(seconds: 1), (_) {
      updateValues(); // TODO: PUT THIS AS A SEPARATE METHOD
    });
  }

  int initialPage() {
    return DogManager().getDogIndex() == null
        ? dogIndex
        : DogManager().getDogIndex()!;
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
    await UserRepository().removeFavDog(user.value.id, dogId);
    user.value.favDogs.remove(dogId);
  }

  // TODO: Put this as a service
  void likeDog(String dogId) async {
    await UserRepository().addFavDog(user.value.id, dogId);
    user.value.favDogs.add(dogId);
  }

  // TODO: Put this as a service
  bool isDogLiked(String dogId) {
    for (int i = 0; i < user.value.favDogs.length; i++) {
      if (dogId == user.value.favDogs[i]) {
        return true;
      }
    }
    return false;
  }

  void navigateToDogInfo(Dog dog) {
    DogManager().setCurrentDogByID(dog.id);
    ShelterManager().setCurrentShelterByID(dog.shelterID);
    Get.toNamed(Routes.DOG_INFO);
  }

  Future<void> updateValues() async {
    user.value = (await Auth().retrieveUser())!;
  }
}
