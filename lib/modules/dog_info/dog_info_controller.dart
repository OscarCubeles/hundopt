import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/chat_repository.dart';
import 'package:hundopt/api/firebase_core/shelter_repository.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';
import 'package:hundopt/shared/services/shelter_singleton.dart';

import '../../api/firebase_core/auth.dart';
import '../../api/firebase_core/dog_repository.dart';
import '../../api/firebase_core/user_repository.dart';
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
  Rx<HundoptUser> user = HundoptUser.empty().obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
    if(ShelterSingleton().shelters == []){
      await ShelterRepository().retrieveShelters();
    }
    user.value = (await Auth().retrieveUser())!;

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
      return;
    }
    Get.toNamed(Routes.DOG_INFO + Routes.RESERVED_DOG);
  }

  // TODO: Put this as a service
  void dislikeDog(String dogId) async {
    await UserRepository().removeFavDog(user.value.id, dogId);
    user.value.favDogs.remove(dogId);
  }

  // TODO: Put this as a service
  void likeDog(String dogId) async {
    await UserRepository().addFavDog(user.value.id, dogId);
    user.value.favDogs.add(dogId);
  }

  // TODO: Put this as a service
  bool isDogLiked(String dogId) {
    for (int i = 0; i < user.value.favDogs.length; i++) {
      if (dogId == user.value.favDogs[i]) {
        return true;
      }
    }
    return false;
  }

  // TODO: Add this as a service
  void toggleLikeStatus(String dogId) {
    if (isDogLiked(dogId)) {
      dislikeDog(dogId);
      return;
    }
    likeDog(dogId);
  }

  void reserveAndContinue() async {
    currentDog().isReserved = true;
    dog!.isReserved = true;
    await DogRepository().reserveDog(dog!.id);
    await ChatRepository().getOrCreateChat(user.value.id, currentDog()); //TODO: REMOVE THE RETURN OF THE CHAT AS IT IS NOT NECESSARY
    Get.toNamed(Routes.INDIVIDUAL_CHAT);
  }

  void navigateToSingleChat() async {
    await ChatRepository().getOrCreateChat(user.value.id, currentDog());
    Get.toNamed(Routes.INDIVIDUAL_CHAT, arguments: Chat.empty());
  }

  void navigateBack() {
    Get.toNamed(Routes.DOG_INFO, arguments: dog);
  }

  void navigateToShelterScreen(){
    Get.toNamed(Routes.SHELTER_PROFILE);
  }


}
