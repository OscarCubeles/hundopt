import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/shelter_repository.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';
import 'package:hundopt/shared/services/shelter_singleton.dart';

import '../../api/firebase_core/dog_repository.dart';
import '../../models/dog.dart';
import '../../models/shelter.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

class DogInfoController extends GetxController {
  Dog dog = Get.arguments;
  RxInt imageIndex = 0.obs;
  Rx<Shelter> dogShelter = Shelter.empty().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
    if(ShelterSingleton().shelters == null){
      await ShelterRepository().retrieveShelters();
    }
    retrieveShelter();
  }

  void retrieveShelter(){
    for(Shelter shelter in ShelterSingleton().shelters!){
      if(shelter.id == currentDog().shelterID){
        copyShelter(shelter);
        print(shelter.id);
      }
    }
  }

  void copyShelter(Shelter srcShelter){
    dogShelter.value.location = srcShelter.location;
    dogShelter.value.name = srcShelter.name;
    dogShelter.value.pictureURL = srcShelter.pictureURL;
  }

  Dog currentDog() {
    return DogSingleton().dogs![DogSingleton().dogIndex!];
  }

  void updateIndex(int index) {
    imageIndex.value = index;
    print("objecthols");
  }

  void navigateToExplore() {
    Get.offNamed(Routes.HOME, arguments: 0);
  }

  void showConfirmAdoptDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: "${StringConstants.titleAdoptDialogText}${dog.name}!",
            text: StringConstants.bodyAdoptDialogText,
            buttonText: StringConstants.btnConfirmAdoptLabel,
            underlinedText: StringConstants.btnConfirmContactLabel,
            buttonColor: ColorConstants.appColor,
            onPressed: () => toShowAdoptDetails(),
            onClose: () => Get.back(),
            onTextPressed: () => Get.back(),
          );
        });
  }

  void toShowAdoptDetails() {
    Get.toNamed(Routes.DOG_INFO + Routes.RESERVED_DOG);
  }

  void navigateToSingleChat() {
    Get.toNamed(Routes.INDIVIDUAL_CHAT, arguments: dog);
  }

  void navigateBack() {
    Get.toNamed(Routes.DOG_INFO, arguments: dog);
  }

  Widget getTimeline(int index, height) {
    return index != 10
        ? Container(
            padding: EdgeInsets.all(10),
          )
        : Padding(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              width: 4,
              height: computeHeight(index, height),
              color: ColorConstants.appColor,
            ),
            padding: EdgeInsets.fromLTRB(17.5, 0, 0, 0),
          );
  }

  Widget getCustomPadding(int index, height) {
    return index == 0
        ? Container(
            padding: EdgeInsets.all(10),
          )
        : Padding(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              width: 4,
              height: computeHeight(index, height),
              color: ColorConstants.black,
            ),
            padding: EdgeInsets.fromLTRB(17.5, 0, 0, 0),
          );
  }

  double computeHeight(int index, height) {
    return index != 2 ? height : (height + 40);
  }
}
