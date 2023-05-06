import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/dog.dart';
import '../../models/dog_feature.dart';

class DogInfoController extends GetxController{
  Dog dog = Get.arguments;
  RxInt imageIndex = 0.obs;

  List<DogFeature> positiveDogFeatures = [];
  List<DogFeature> negativeDogFeatures = [];


  @override
  void onInit() {
    addFeature(DogFeature("Perros macho", CupertinoIcons.checkmark_square_fill, Colors.red));
    addFeature(DogFeature("Perros macho", CupertinoIcons.checkmark_square_fill, Colors.red));
    addFeature(DogFeature("Perros macho", CupertinoIcons.checkmark_square_fill, Colors.red));
  }

  void updateIndex(int index){
    imageIndex.value = index;
  }

  void addFeature(DogFeature dogFeature) {
    positiveDogFeatures.add(dogFeature);
    negativeDogFeatures.add(dogFeature);
  }



}