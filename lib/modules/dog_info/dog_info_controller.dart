import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/dog.dart';
import '../../models/dog_feature.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

class DogInfoController extends GetxController {
  Dog dog = Get.arguments;
  RxInt imageIndex = 0.obs;

  List<DogFeature> positiveDogFeatures = [];
  List<DogFeature> negativeDogFeatures = [];

  @override
  void onInit() {
    addFeature(DogFeature(
        "Perros macho", CupertinoIcons.checkmark_square_fill, Colors.red));
    addFeature(DogFeature(
        "Perros macho", CupertinoIcons.checkmark_square_fill, Colors.red));
    addFeature(DogFeature(
        "Perros macho", CupertinoIcons.checkmark_square_fill, Colors.red));
  }

  void updateIndex(int index) {
    imageIndex.value = index;
  }

  void addFeature(DogFeature dogFeature) {
    positiveDogFeatures.add(dogFeature);
    negativeDogFeatures.add(dogFeature);
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
        ? Container(padding: EdgeInsets.all(10),)
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
        ? Container(padding: EdgeInsets.all(10),)
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

  double computeHeight(int index, height){
    return index != 2 ? height : (height + 40);
  }


}
