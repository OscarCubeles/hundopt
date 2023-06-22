import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/shared.dart';
import '../../../../api/firebase_core/firebase_core.dart';
import '../../../../models/model.dart';
import '../../../../routes/app_pages.dart';

class FavouriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TextStyle centreLabelStyle;
  late TextStyle dogLabelStyle;
  late Rx<HundoptUser> user = HundoptUser.empty().obs;
  late TabController tabBarController;
  final _selectedIndex = 0.obs;
  RxList favDogs = [].obs;
  RxList favShelters = [].obs;

  @override
  void onInit() async {
    super.onInit();
    initTabController();
    retrieveData();
    update();
  }

  void retrieveData() async {
    user.value = (await Auth().retrieveUser())!;
    await ShelterManager().retrieveShelters();
  }

  void initTabController() {
    tabBarController = TabController(length: 2, vsync: this);
    tabBarController.addListener(() async {
      _selectedIndex.value = tabBarController.index;
      await updateValues();
    });
  }

  Future<void> updateValues() async {
    user.value = (await Auth().forceRetrieveUser())!;
    final updatedShelters =
        await ShelterRepository().fetchFavShelters(user.value);
    final updatedDogs = await DogRepository().fetchFavDogs(user.value);
    favShelters.assignAll(updatedShelters);
    favDogs.assignAll(updatedDogs);
    update();
  }

  void toggleShelterLikeStatus(Shelter shelter) {
    if (isShelterLiked(shelter.id)) {
      dislikeShelter(shelter);
    } else {
      likeShelter(shelter);
    }
  }

  void dislikeShelter(Shelter shelter) async {
    await UserRepository().removeFavShelter(user.value.id, shelter.id);
    user.update((value) {
      value?.favShelters.remove(shelter.id);
    });
    favShelters.remove(shelter);
  }

  void likeShelter(Shelter shelter) async {
    await UserRepository().addFavShelter(user.value.id, shelter.id);
    user.update((value) {
      value?.favShelters.add(shelter.id);
    });
    favShelters.add(shelter);
  }

  bool isShelterLiked(String shelterID) {
    for (int i = 0; i < user.value.favShelters.length; i++) {
      if (shelterID == user.value.favShelters[i]) {
        return true;
      }
    }
    return false;
  }

  void toggleDogLikeStatus(Dog dog) {
    if (isDogLiked(dog.id)) {
      dislikeDog(dog);
    } else {
      likeDog(dog);
    }
  }

  void dislikeDog(Dog dog) async {
    await UserRepository().removeFavDog(user.value.id, dog.id);
    user.update((value) {
      value?.favDogs.remove(dog.id);
    });
    favDogs.remove(dog);
  }

  void likeDog(Dog dog) async {
    await UserRepository().addFavDog(user.value.id, dog.id);
    user.update((value) {
      value?.favDogs.add(dog.id);
    });
    favDogs.add(dog);
  }

  bool isDogLiked(String dogId) {
    for (int i = 0; i < user.value.favDogs.length; i++) {
      if (dogId == user.value.favDogs[i]) {
        return true;
      }
    }
    return false;
  }

  void navigateToDogInfo(Dog dog) {
    DogManager().setCurrentDog(dog);
    ShelterManager().setCurrentShelterByID(dog.shelterID);
    Get.toNamed(Routes.DOG_INFO);
  }

  void navigateToShelter(Shelter shelter) {
    ShelterManager().setCurrentShelter(shelter);
    Get.toNamed(Routes.SHELTER_PROFILE);
  }
}
