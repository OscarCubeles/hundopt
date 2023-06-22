import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/shared.dart';
import '../../api/firebase_core/firebase_core.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';

class DogInfoController extends GetxController {
  RxInt imageIndex = 0.obs;
  Rx<Shelter> dogShelter = Shelter.empty().obs;
  Rx<HundoptUser> user = HundoptUser.empty().obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    await DogManager().retrieveDogs();
    await ShelterManager().retrieveShelters();

    user.value = (await Auth().retrieveUser())!;

    retrieveShelter();
  }

  void retrieveShelter(){
    ShelterManager().setCurrentShelterByID(currentDog().shelterID);
    copyShelter(ShelterManager().currentShelter());
  }

  void copyShelter(Shelter srcShelter){
    dogShelter.value.id = srcShelter.id;
    dogShelter.value.location = srcShelter.location;
    dogShelter.value.name = srcShelter.name;
    dogShelter.value.pictureURL = srcShelter.pictureURL;
    dogShelter.value.email = srcShelter.email;
  }

  Dog currentDog() {
    return DogManager().currentDog();
  }

  Shelter currentShelter(){
    return ShelterManager().currentShelter();
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
            title: "${StringConstants.titleAdoptDialogText}${currentDog().name}!",
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
    if(currentDog().isReserved){
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
    await DogRepository().reserveDog(currentDog().id);
    await UserRepository().addAdoptingDog(user.value.id, currentDog().id);
    await ChatRepository().getOrCreateChat(user.value.id, currentDog());
    Get.toNamed(Routes.INDIVIDUAL_CHAT);
  }

  void navigateToSingleChat() async {
    await ChatRepository().getOrCreateChat(user.value.id, currentDog());
    Get.toNamed(Routes.INDIVIDUAL_CHAT, arguments: Chat.empty());
  }

  void navigateBack() {
    Get.toNamed(Routes.DOG_INFO, arguments: currentDog());
  }

  void navigateToShelterScreen(){
    Get.toNamed(Routes.SHELTER_PROFILE);
  }


}
