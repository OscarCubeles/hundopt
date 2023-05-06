import 'dart:ui' as ui;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/constants/colors.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:video_player/video_player.dart';

import '../../../models/dog.dart';

class ExploreController extends GetxController {
  final Rx<List<Dog>> _dogList = Rx<List<Dog>>([]);

  List<Dog> get dogList => _dogList.value;
  late VideoPlayerController videoController;
  RxBool isLiked = false.obs;
  Rx<Color> _textColor = ColorConstants.background.obs;
  RxBool isWhite = false.obs;
  GlobalKey _globalKey = GlobalKey();
  VideoPlayerController get videoPlayerController1 => videoController;

  @override
  void onInit() {
    addDog(Dog(
        name: "Kira",
        videoUrl: "assets/images/kira-dog.JPG",
        location: "Barcelona"));
    addDog(Dog(
        name: "Kira",
        videoUrl: "assets/images/kira-dog2.JPG",
        location: "Barcelona"));
    addDog(Dog(
        name: "Kira",
        videoUrl: "assets/images/kira-dog3.JPG",
        location: "Barcelona"));
    addDog(Dog(
        name: "Kira",
        videoUrl: "assets/images/kira-dog4.JPG",
        location: "Barcelona"));
    addDog(Dog(
        name: "Kira",
        videoUrl: "assets/images/kira-dog5.JPG",
        location: "Barcelona"));
    videoController = VideoPlayerController.network(
      'https://lifetime-app.be/wp-content/uploads/2020/08/IMG_5648-1.mp4',
    );
  }


  void changeTextColor (int index) async {
    print(index);
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            AssetImage(dogList[index].videoUrl));
    final dominantColor = paletteGenerator.dominantColor?.color;
    if (dominantColor != null) {
      // Use a relative luminance threshold to decide the text color
      final luminance = dominantColor.computeLuminance();
      if (luminance > 0.5) {
        _textColor.value = Colors.black;
        isWhite.value = false;
      } else {
        _textColor.value = ColorConstants.background;
        isWhite.value = true;
      }
    } else {
      _textColor.value = ColorConstants.background;
      isWhite.value = true;
    }
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
