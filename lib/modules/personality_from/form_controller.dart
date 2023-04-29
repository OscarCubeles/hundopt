import 'package:get/get.dart';

class FormController extends GetxController {
  RxDouble progress = 0.0.obs;
  void increment() {
    progress.value < (1-(1/7)) ? progress.value+=1/7 : null;
  }

}

