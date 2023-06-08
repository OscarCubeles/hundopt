import 'dart:ui' as ui;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/dog_repository.dart';
import 'package:hundopt/shared/constants/colors.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:video_player/video_player.dart';

import '../../../api/firebase_core/shelter_repository.dart';
import '../../../models/dog.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/services/shelter_singleton.dart';

class ExploreController extends GetxController {
  final Rx<List<Dog>> _dogList = Rx<List<Dog>>([]);
  int dogIndex = 0;

  List<Dog> get dogList => _dogList.value;
  late VideoPlayerController videoController;
  RxBool isLiked = false.obs;

  VideoPlayerController get videoPlayerController1 => videoController;

  @override
  void onInit() async {
    super.onInit();
    //final shuffledDogs = List<Dog>.from(dogSingleton.dogs!);
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
        print(ShelterSingleton().shelters[i].name);
        return;
      }
    }
  }

  void navigateToDogInfo(int index) {
    DogSingleton().dogIndex = index;
    print("dogindex: $index");
    print("dog");
    print(DogSingleton().dogs![DogSingleton().dogIndex!].id);
    print("name");
    print(DogSingleton().dogs![DogSingleton().dogIndex!].name);
    print("Shelter");
    print(DogSingleton().dogs![DogSingleton().dogIndex!].shelterID);

    retrieveShelter();
    Get.offNamed(Routes.DOG_INFO, arguments: dogList[index]);
  }

  void likeDog() {
    isLiked.value = !isLiked.value;
    print("liked");
  }

  void addDog(Dog dog) {
    dogList.add(dog);
  }

  onPageChanged(int index) {
    print("page changed");
  }
}
