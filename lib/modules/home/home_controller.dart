import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  increment() => count.value++;
}
