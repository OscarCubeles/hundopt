import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api/firebase_core/dog_repository.dart';
import '../../api/firebase_core/shelter_repository.dart';
import '../../models/dog.dart';
import '../../models/shelter.dart';
import '../../routes/app_pages.dart';
import '../../shared/services/dog_singleton.dart';
import '../../shared/services/shelter_singleton.dart';

class IndividualChatController extends GetxController{
  final ScrollController scrollController = ScrollController();
  //final Dog dog = Get.arguments[0];
  //final Rx<Shelter> shelter = Get.arguments[1];


  @override
  void onInit() async{
    super.onInit();
    //scrollToBottom();
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
    if(ShelterSingleton().shelters == []){
      await ShelterRepository().retrieveShelters();
    }

    retrieveShelter();
  }

  void retrieveShelter() {
    for(int i = 0; i < ShelterSingleton().shelters.length; i++){
      if(ShelterSingleton().shelters[i].id == currentDog().shelterID){
        ShelterSingleton().shelterIndex = i;
      }
    }
  }

  @override
  void onReady() {
   // scrollToBottom();
  }

  Dog currentDog() {
    return DogSingleton().dogs![DogSingleton().dogIndex!];
  }

  Shelter currentShelter(){
    return ShelterSingleton().shelters[ShelterSingleton().shelterIndex];
  }

  void scrollToBottom() { // TODO: This throws an error on console, check why
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 1),
      curve: Curves.easeOut,
    );
  }

  void navigateToChats(){ // TODO: Change this
    Get.offNamed(Routes.HOME, arguments: 1);
  }
  
  void navigateToShelter(){
    Get.toNamed(Routes.SHELTER_PROFILE);
    print("pressde");// TODO: We should pass the shelter here when pressed
  }

  void getToDogInfo(){
    Get.toNamed(Routes.DOG_INFO, arguments: currentDog()); // TODO: Revise if it is necessary to pass the dog
  }



}