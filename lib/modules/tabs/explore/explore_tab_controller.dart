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

import '../../../models/dog.dart';
import '../../../routes/app_pages.dart';

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
  }

  int initialPage() {
    return DogSingleton().dogIndex == null
        ? dogIndex
        : DogSingleton().dogIndex!;
  }

  void navigateToDogInfo(int index) {
    print(index);
    DogSingleton().dogIndex = index;
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
