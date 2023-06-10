import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/shelter_repository.dart';
import 'package:hundopt/shared/constants/colors.dart';
import 'package:hundopt/shared/services/shelter_singleton.dart';

import '../../../api/firebase_core/auth.dart';
import '../../../api/firebase_core/dog_repository.dart';
import '../../../models/dog.dart';
import '../../../models/shelter.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/services/dog_singleton.dart';

class FavouriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TextStyle centreLabelStyle;
  late TextStyle dogLabelStyle;
  late Color centreBtnColor;
  late Color dogBtnColor;
  late HundoptUser user = HundoptUser.empty();
  RxList favDogs = [].obs;
  RxList favShelters = [].obs;


  late TabController tabBarController;
  var _selectedIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    centreBtnColor = Colors.black;
    dogBtnColor = ColorConstants.appColor;
    tabBarController = TabController(length: 2, vsync: this);
    user = (await Auth().retrieveUser())!;

    tabBarController.addListener(() {
      _selectedIndex.value = tabBarController.index;
    });

    favShelters.assignAll(await ShelterRepository().fetchFavShelters(user));
    favDogs.assignAll(await DogRepository().fetchFavDogs(user));
    print("dogs retrieved");
    update();
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

  void navigateToShelter(Shelter shelter){
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
    print("pressde");// TODO: We should pass the shelter here when pressed
  }

  void swapColors() {}

  void centreBtnPressed() {}

  void dogBtnPressed() {}
}
