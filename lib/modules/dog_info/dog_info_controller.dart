import 'package:get/get.dart';

import '../../models/dog.dart';

class DogInfoController extends GetxController{
  Dog dog = Get.arguments;
  RxInt imageIndex = 0.obs;

  void updateIndex(int index){
    imageIndex.value = index;
  }


}