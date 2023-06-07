import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';

import '../../api/firebase_core/dog_repository.dart';
import '../../models/dog.dart';
import '../../models/dog_feature.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

class DogInfoController extends GetxController {
  Dog dog = Get.arguments;
  RxInt imageIndex = 0.obs;
  List<String> positiveDogFeatures = [];
  List<String> negativeDogFeatures = [];
  List<String> personalityTraits = [];
  List<String> friendly = [];
  List<String> notFriendly = [];
  bool featuresRetrieved = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
    await retrieveDogFeatures();
  }

  void initLists() {
    positiveDogFeatures = [];
    negativeDogFeatures = [];
    personalityTraits = [];
    friendly = [];
    notFriendly = [];
  }

  Future<void> retrieveDogFeatures() async {
    if (!featuresRetrieved) {
      await DogRepository().retrieveDogs();
      for (String healthItem in currentDog().healthPositive) {
        addPositiveFeature(healthItem);
      }
      for (String healthItem in currentDog().healthNegative) {
        addNegativeFeature(healthItem);
      }
      for (String trait in currentDog().personality) {
        addTrait(trait);
      }
      for (String friendly in currentDog().friendly) {
        addFriendlyFeature(friendly);
      }
      for (String notFriendly in currentDog().notFriendly) {
        addNotFriendlyFeature(notFriendly);
      }
    }
  }

  void addFriendlyFeature(String feature) {
    friendly.add(feature);
  }

  void addTrait(String trait) {
    personalityTraits.add(trait);
  }

  void addNotFriendlyFeature(String feature) {
    notFriendly.add(feature);
  }

  void addPositiveFeature(String feature) {
    positiveDogFeatures.add(feature);
  }

  void addNegativeFeature(String feature) {
    negativeDogFeatures.add(feature);
  }

  Dog currentDog() {
    return DogSingleton().dogs![DogSingleton().dogIndex!];
  }

  void updateIndex(int index) {
    imageIndex.value = index;
  }

  void navigateToExplore() {
    Get.toNamed(Routes.HOME, arguments: 0);
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
