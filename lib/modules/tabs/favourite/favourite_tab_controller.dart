import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/shelter_repository.dart';
import 'package:hundopt/shared/services/shelter_singleton.dart';

import '../../../api/firebase_core/auth.dart';
import '../../../api/firebase_core/dog_repository.dart';
import '../../../api/firebase_core/user_repository.dart';
import '../../../models/dog.dart';
import '../../../models/shelter.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/services/dog_singleton.dart';
import 'dart:async';


class FavouriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TextStyle centreLabelStyle;
  late TextStyle dogLabelStyle;
  late Timer _timer;


  late Rx<HundoptUser> user = HundoptUser.empty().obs;
  RxList favDogs = [].obs;
  RxList favShelters = [].obs;

  late TabController tabBarController;
  var _selectedIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    tabBarController = TabController(length: 2, vsync: this);
    user.value = (await Auth().retrieveUser())!;
    // TODO: CLean this ugly line of code
    tabBarController.addListener(() async {
      _selectedIndex.value = tabBarController.index;
      await updateValues();
    });
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      updateValues();
    });
    favShelters
        .assignAll(await ShelterRepository().fetchFavShelters(user.value));
    favDogs.assignAll(await DogRepository().fetchFavDogs(user.value));
    print("dogs retrieved");
    update();
  }

  Future updateValues() async{
    favShelters
        .assignAll(await ShelterRepository().fetchFavShelters(user.value));
    favDogs.assignAll(await DogRepository().fetchFavDogs(user.value));
  }

  // TODO: Add this as a service
  void toggleShelterLikeStatus(Shelter shelter) {
    if (isShelterLiked(shelter.id)) {
      print("disliked");
      dislikeShelter(shelter);
      return;
    }
    print("liked");
    likeShelter(shelter);
  }

  // TODO: Put this as a service
  void dislikeShelter(Shelter shelter) async {
    await UserRepository().removeFavShelter(user.value.id, shelter.id);
    user.update((value) {
      value?.favShelters.add(shelter.id);
    });
    favShelters.remove(shelter);
  }

  // TODO: Put this as a service
  void likeShelter(Shelter shelter) async {
    await UserRepository().addFavShelter(user.value.id, shelter.id);
    user.update((value) {
      value?.favShelters.add(shelter.id);
    });
    favShelters.add(shelter);
  }

  // TODO: Put this as a service
  bool isShelterLiked(String shelterID) {
    for (int i = 0; i < user.value.favShelters.length; i++) {
      if (shelterID == user.value.favShelters[i]) {
        return true;
      }
    }
    return false;
  }

  // TODO: Add this as a service
  void toggleDogLikeStatus(Dog dog) {
    if (isDogLiked(dog.id)) {
      print("disliked");
      dislikeDog(dog);
      return;
    }
    print("liked");
    likeDog(dog);
  }

  // TODO: Put this as a service
  void dislikeDog(Dog dog) async {
    await UserRepository().removeFavDog(user.value.id, dog.id);
    user.update((value) {
      value?.favDogs.remove(dog.id);
    });
    favDogs.remove(dog);
  }

  // TODO: Put this as a service
  void likeDog(Dog dog) async {
    await UserRepository().addFavDog(user.value.id, dog.id);
    user.update((value) {
      value?.favDogs.add(dog.id);
    });
    favDogs.add(dog);
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

  navigateToDogInfo(Dog dog) {
    print("${dog.name}");
    // TODO: Add this method in the service that uses the singleton, the service could be called dogmanager
    int i = 0;
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (dog.id == tmpDog.id) {
        DogSingleton().dogIndex = i;
        Get.toNamed(Routes.DOG_INFO, arguments: tmpDog);
        break;
      }
      i++;
    }
  }

  void navigateToShelter(Shelter shelter) {
    // TODO: Make this as a service with a method named SetCurrentShelter  or similar
    int i = 0;
    for (Shelter tmpShelter in ShelterSingleton().shelters) {
      if (shelter.id == tmpShelter.id) {
        ShelterSingleton().shelterIndex = i;
        Get.toNamed(Routes.SHELTER_PROFILE);
        break;
      }
      i++;
    }
    Get.toNamed(Routes.SHELTER_PROFILE);
    print("pressde"); // TODO: We should pass the shelter here when pressed
  }

  void swapColors() {}

  void centreBtnPressed() {}

  void dogBtnPressed() {}
}
