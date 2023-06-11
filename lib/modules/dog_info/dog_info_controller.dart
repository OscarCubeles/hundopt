import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/chat_repository.dart';
import 'package:hundopt/api/firebase_core/shelter_repository.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';
import 'package:hundopt/shared/services/shelter_singleton.dart';

import '../../api/firebase_core/auth.dart';
import '../../api/firebase_core/dog_repository.dart';
import '../../models/chat.dart';
import '../../models/dog.dart';
import '../../models/shelter.dart';
import '../../models/user.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

class DogInfoController extends GetxController {
  Dog? dog = Get.arguments; // TODO: Check if this is really useful bc at the end it is using the dogSingleton
  RxInt imageIndex = 0.obs;
  Rx<Shelter> dogShelter = Shelter.empty().obs;
  late HundoptUser user = HundoptUser.empty();


  @override
  Future<void> onInit() async {
    super.onInit();
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
    if(ShelterSingleton().shelters == []){
      await ShelterRepository().retrieveShelters();
    }
    user = (await Auth().retrieveUser())!;

    retrieveShelter();
  }

  void retrieveShelter(){
    for(int i = 0; i < ShelterSingleton().shelters.length; i++){
      if(ShelterSingleton().shelters[i].id == currentDog().shelterID){
          ShelterSingleton().shelterIndex = i;
      }
    }
    for(Shelter shelter in ShelterSingleton().shelters){
      if(shelter.id == currentDog().shelterID){
        copyShelter(shelter);
      }
    }
  }

  void copyShelter(Shelter srcShelter){
    dogShelter.value.id = srcShelter.id;
    dogShelter.value.location = srcShelter.location;
    dogShelter.value.name = srcShelter.name;
    dogShelter.value.pictureURL = srcShelter.pictureURL;
    dogShelter.value.email = srcShelter.email;
  }

  Dog currentDog() {
    // TODO: Put this as a service
    return DogSingleton().dogs![DogSingleton().dogIndex!];
  }

  Shelter currentShelter(){
    // TODO: Put this as a service
    return ShelterSingleton().shelters[ShelterSingleton().shelterIndex];
  }

  void updateIndex(int index) {
    imageIndex.value = index;
  }

  void navigateToExplore() {
    Get.offNamed(Routes.HOME, arguments: 0);
  }

  void showConfirmAdoptDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: "${StringConstants.titleAdoptDialogText}${dog!.name}!",
            text: StringConstants.bodyAdoptDialogText,
            buttonText: StringConstants.btnConfirmAdoptLabel,
            underlinedText: StringConstants.btnConfirmContactLabel,
            buttonColor: ColorConstants.appColor,
            onPressed: () => toShowAdoptDetails(),
            onClose: () => Get.back(),
            onTextPressed: () => navigateToSingleChat(),
          );
        });
  }



  void toShowAdoptDetails() {
    // TODO: Check why this redirect does not work
    if(dog!.isReserved || currentDog().isReserved){
      Get.toNamed(Routes.INDIVIDUAL_CHAT);
    }
    Get.toNamed(Routes.DOG_INFO + Routes.RESERVED_DOG);
  }

  void reserveAndContinue() async {
    currentDog().isReserved = true;
    dog!.isReserved = true;
    await DogRepository().reserveDog(dog!.id);
    print("hadaksdjadkja");
  // TODO: Check if the user has already chatted with the shelter, if not, create the chat, if yes, gather it
    await ChatRepository().getOrCreateChat(user.id, currentDog()); //TODO: REMOVE THE RETURN OF THE CHAT AS IT IS NOT NECESSARY
    Get.toNamed(Routes.INDIVIDUAL_CHAT);
  }

  void navigateToSingleChat() async {
    // TODO: Check if the user has already chatted with the shelter, if not, create the chat, if yes, gather it
    await ChatRepository().getOrCreateChat(user.id, currentDog());
    Get.toNamed(Routes.INDIVIDUAL_CHAT, arguments: Chat.empty());
  }

  void navigateBack() {
    Get.toNamed(Routes.DOG_INFO, arguments: dog);
  }

  void navigateToShelterScreen(){
    Get.toNamed(Routes.SHELTER_PROFILE);
  }


}
