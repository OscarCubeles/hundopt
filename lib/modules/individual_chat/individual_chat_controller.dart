import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class IndividualChatController extends GetxController{
  final ScrollController scrollController = ScrollController();

  @override
  void onReady() {
    scrollToBottom();
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 1),
      curve: Curves.easeOut,
    );
  }
  
  void navigateToShelter(){
    Get.toNamed(Routes.SHELTER_PROFILE);
    print("pressde");// TODO: We should pass the shelter here when pressed
  }

}