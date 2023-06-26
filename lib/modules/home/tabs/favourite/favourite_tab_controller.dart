import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/shared.dart';
import '../../../../api/firebase_core/firebase_core.dart';
import '../../../../models/model.dart';
import '../../../../routes/app_pages.dart';

/// The [FavouriteController] manages the data for the Favourite screen.
class FavouriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// A text style for the center label.
  late TextStyle centreLabelStyle;

  /// A text style for the dog label.
  late TextStyle dogLabelStyle;

  /// A reactive user.
  late Rx<HundoptUser> user = HundoptUser.empty().obs;

  /// A tab controller for the favourite screen.
  late TabController tabBarController;

  /// An observable integer representing the selected index.
  final _selectedIndex = 0.obs;

  /// A reactive list of favorite dogs.
  RxList favDogs = [].obs;

  /// A reactive list of favorite shelters.
  RxList favShelters = [].obs;

  @override
  void onInit() async {
    super.onInit();
    initTabController();
    retrieveData();
    update();
  }

  /// Retrieves the user data and shelters from the database.
  void retrieveData() async {
    user.value = (await Auth().retrieveUser())!;
    await ShelterManager().retrieveShelters();
  }

  /// Initializes the tab controller.
  void initTabController() {
    tabBarController = TabController(length: 2, vsync: this);
    tabBarController.addListener(() async {
      _selectedIndex.value = tabBarController.index;
      await updateValues();
    });
  }

  /// Updates the user data and favorite dogs and shelters.
  Future<void> updateValues() async {
    user.value = (await Auth().forceRetrieveUser())!;
    final updatedShelters =
        await ShelterRepository().fetchFavShelters(user.value);
    final updatedDogs = await DogRepository().fetchFavDogs(user.value);
    favShelters.assignAll(updatedShelters);
    favDogs.assignAll(updatedDogs);
    update();
  }

  /// Toggles the like status of a shelter.
  ///
  /// The [shelter] parameter is the shelter to toggle the like status.
  /// If the shelter is already liked, it calls the `dislikeShelter` method.
  /// Otherwise, it calls the `likeShelter` method.
  void toggleShelterLikeStatus(Shelter shelter) {
    if (isShelterLiked(shelter.id)) {
      dislikeShelter(shelter);
    } else {
      likeShelter(shelter);
    }
  }

  /// Removes a shelter from the user's favorite shelters list.
  ///
  /// The [shelter] parameter is the shelter to remove from the user's favorite shelters list.
  /// It removes the shelter from the database using the `UserRepository` class and removes it from the `favShelters` list of the user.
  void dislikeShelter(Shelter shelter) async {
    await UserRepository().removeFavShelter(user.value.id, shelter.id);
    user.update((value) {
      value?.favShelters.remove(shelter.id);
    });
    favShelters.remove(shelter);
  }

  /// Adds a shelter to the user's favorite shelters list.
  ///
  /// The [shelter] parameter is the shelter to add to the user's favorite shelters list.
  /// It adds the shelter to the database using the `UserRepository` class and adds it to the `favShelters` list of the user.
  void likeShelter(Shelter shelter) async {
    await UserRepository().addFavShelter(user.value.id, shelter.id);
    user.update((value) {
      value?.favShelters.add(shelter.id);
    });
    favShelters.add(shelter);
  }

  /// Checks if a shelter is liked by the user.
  ///
  /// The [shelterID] parameter is the id of the shelter to check if it is liked by the user.
  /// It returns true if the shelter is in the `favShelters` list of the user, otherwise, it returns false.
  bool isShelterLiked(String shelterID) {
    for (int i = 0; i < user.value.favShelters.length; i++) {
      if (shelterID == user.value.favShelters[i]) {
        return true;
      }
    }
    return false;
  }

  /// Toggles the like status of a dog.
  ///
  /// The [dog] parameter is the dog to toggle the like status.
  /// If the dog is already liked, it calls the `dislikeDog` method.
  /// Otherwise, it calls the `likeDog` method.
  void toggleDogLikeStatus(Dog dog) {
    if (isDogLiked(dog.id)) {
      dislikeDog(dog);
    } else {
      likeDog(dog);
    }
  }

  /// Removes a dog from the user's favorite dogs list.
  ///
  /// The [dog] parameter is the dog to remove from the user's favorite dogs list.
  /// It removes the dog from the database using the `UserRepository` class and removes it from the `favDogs` list of the user.
  void dislikeDog(Dog dog) async {
    await UserRepository().removeFavDog(user.value.id, dog.id);
    user.update((value) {
      value?.favDogs.remove(dog.id);
    });
    favDogs.remove(dog);
  }

  /// Adds a dog to the user's favorite dogs list.
  ///
  /// The [dog] parameter is the dog to add to the user's favorite dogs list.
  /// It adds the dog to the database using the `UserRepository` class and adds it to the `favDogs` list of the user.
  void likeDog(Dog dog) async {
    await UserRepository().addFavDog(user.value.id, dog.id);
    user.update((value) {
      value?.favDogs.add(dog.id);
    });
    favDogs.add(dog);
  }

  /// Checks if a dog is liked by the user.
  ///
  /// The [dogId] parameter is the id of the dog to check if it is liked by the user.
  /// It returns true if the dog is in the `favDogs` list of the user, otherwise, it returns false.
  bool isDogLiked(String dogId) {
    for (int i = 0; i < user.value.favDogs.length; i++) {
      if (dogId == user.value.favDogs[i]) {
        return true;
      }
    }
    return false;
  }

  /// Navigates to the Dog Info screen setting the current dog and current shelter in the data managers
  void navigateToDogInfo(Dog dog) {
    DogManager().setCurrentDog(dog);
    ShelterManager().setCurrentShelterByID(dog.shelterID);
    Get.toNamed(Routes.DOG_INFO);
  }

  /// Navigates to the shelter screen setting the current shelter in the data managers
  void navigateToShelter(Shelter shelter) {
    ShelterManager().setCurrentShelter(shelter);
    Get.toNamed(Routes.SHELTER_PROFILE);
  }
}
