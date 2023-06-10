import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/shelter_repository.dart';
import 'package:hundopt/shared/constants/colors.dart';

import '../../../api/firebase_core/auth.dart';
import '../../../api/firebase_core/dog_repository.dart';
import '../../../models/dog.dart';
import '../../../models/user.dart';

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

  void swapColors() {}

  void centreBtnPressed() {}

  void dogBtnPressed() {}
}
