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

  List<Dog> get dogList => _dogList.value;
  late VideoPlayerController videoController;
  RxBool isLiked = false.obs;
  VideoPlayerController get videoPlayerController1 => videoController;

  @override
  void onInit() async{
    addDog(Dog.simplified(
        name: "Kira",
        mainPictureURL: "https://firebasestorage.googleapis.com/v0/b/hundopt-db.appspot.com/o/kira-dog.JPG?alt=media&token=5b5afaca-cff8-40e9-9e78-8939aa2891b6",
        location: "Barcelona"));
    addDog(Dog.simplified(
        name: "Kira",
        mainPictureURL: "assets/images/kira-dog2.JPG",
        location: "Barcelona"));
    addDog(Dog.simplified(
        name: "Kira",
        mainPictureURL: "assets/images/kira-dog3.JPG",
        location: "Barcelona"));
    addDog(Dog.simplified(
        name: "Andresitoooo",
        mainPictureURL: "assets/images/kira-dog4.JPG",
        location: "Barcelona"));
    addDog(Dog.simplified(
        name: "Kira",
        mainPictureURL: "assets/images/kira-dog5.JPG",
        location: "Barcelona"));
    videoController = VideoPlayerController.network(
      'https://lifetime-app.be/wp-content/uploads/2020/08/IMG_5648-1.mp4',
    );
    //final shuffledDogs = List<Dog>.from(dogSingleton.dogs!);
    if(DogSingleton().dogs == null){
      await DogRepository().retrieveDogs();
    }
    _dogList.value = DogSingleton().dogs!;
  }



  void navigateToDogInfo(int index){
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
