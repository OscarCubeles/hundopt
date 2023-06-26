import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/shared.dart';
import '../../api/firebase_core/firebase_core.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';

/// The [DogInfoController] manages the state of the dog information screen.
class DogInfoController extends GetxController {
  /// The index of the current dog image.
  RxInt imageIndex = 0.obs;

  /// The current dog's shelter.
  Rx<Shelter> dogShelter = Shelter.empty().obs;

  /// The current user.
  Rx<HundoptUser> user = HundoptUser.empty().obs;

  /// Initializes the controller and retrieves the list of dogs and shelters from their respective managers.
  ///
  /// This method sets the `user` reactive variable to the current user and retrieves the current dog's shelter.
  @override
  Future<void> onInit() async {
    super.onInit();
    await DogManager().retrieveDogs();
    await ShelterManager().retrieveShelters();
    user.value = (await Auth().retrieveUser())!;
    retrieveShelter();
  }

  /// Retrieves the current dog's shelter and sets the current shelter based on the current dog's shelter ID.
  ///
  /// This method sets the `dogShelter` reactive variable to the current dog's shelter.
  void retrieveShelter() {
    ShelterManager().setCurrentShelterByID(currentDog().shelterID);
    copyShelter(ShelterManager().currentShelter());
  }

  /// Retrieves the current dog's shelter and sets the current shelter based on the current dog's shelter ID.
  ///
  /// The [srcShelter] parameter is the shelter to copy the values from.
  ///
  /// This method copies the values of the [srcShelter] parameter to the [dogShelter] reactive variable.
  void copyShelter(Shelter srcShelter) {
    dogShelter.value.id = srcShelter.id;
    dogShelter.value.location = srcShelter.location;
    dogShelter.value.name = srcShelter.name;
    dogShelter.value.pictureURL = srcShelter.pictureURL;
    dogShelter.value.email = srcShelter.email;
  }

  /// Returns the current dog.
  ///
  /// This method returns the current dog from the [DogManager].
  Dog currentDog() {
    return DogManager().currentDog();
  }

  /// Returns the current shelter.
  ///
  /// This method returns the current shelter from the [ShelterManager].
  Shelter currentShelter() {
    return ShelterManager().currentShelter();
  }

  /// Updates the image index.
  ///
  /// The [index] parameter is the new index of the current dog image.
  ///
  /// This method updates the [imageIndex] reactive variable with the new [index] parameter.
  void updateIndex(int index) {
    imageIndex.value = index;
  }

  /// Navigates to the explore screen.
  ///
  /// This method navigates to the explore screen using the [Get.offNamed] method with the [Routes.HOME] route and an argument of 0.
  void navigateToExplore() {
    Get.offNamed(Routes.HOME, arguments: 0);
  }

  /// Shows a confirmation dialog for adopting the current dog.
  ///
  /// This method shows a dialog with the title "¿Adoptar a {dog name}?" and the body "¿Estás seguro de que quieres adoptar a {dog name}?".
  /// It also includes two buttons: "Confirmar" and "Contactar al refugio". If the dog is already reserved, the "Contactar al refugio" button navigates to the individual chat screen.
  /// If the dog is not reserved, the "Confirmar" button navigates to the reserved dog screen.
  void showConfirmAdoptDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title:
                "${StringConstants.titleAdoptDialogText}${currentDog().name}!",
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

  /// Navigates to the reserved dog screen or the individual chat screen.
  ///
  /// This method checks if the current dog is reserved.
  /// If it is, it navigates to the individual chat screen using the [Get.toNamed] method with the [Routes.INDIVIDUAL_CHAT] route.
  /// If it is not reserved, it navigates to the reserved dog screen using the [Get.toNamed] method with the [Routes.DOG_INFO]
  /// and [Routes.RESERVED_DOG] routes.
  void toShowAdoptDetails() {
    if (currentDog().isReserved) {
      Get.toNamed(Routes.INDIVIDUAL_CHAT);
      return;
    }
    Get.toNamed(Routes.DOG_INFO + Routes.RESERVED_DOG);
  }

  /// Removes a dog from the user's favorites.
  ///
  /// The [dogId] parameter is the ID of the dog to remove from the user's favorites.
  ///
  /// This method removes the dog with the given [dogId] from the user's favorites
  /// in the database and in the [user] reactive variable.
  void dislikeDog(String dogId) async {
    await UserRepository().removeFavDog(user.value.id, dogId);
    user.value.favDogs.remove(dogId);
  }

  /// Adds a dog to the user's favorites.
  ///
  /// The [dogId] parameter is the ID of the dog to add to the user's favorites.
  ///
  /// This method adds the dog with the given [dogId] to the user's favorites in the database and in the [user] reactive variable.
  void likeDog(String dogId) async {
    await UserRepository().addFavDog(user.value.id, dogId);
    user.value.favDogs.add(dogId);
  }

  /// Checks if a dog is liked by the user.
  ///
  /// The [dogId] parameter is the ID of the dog to check.
  ///
  /// This method checks if the dog with the given [dogId] is in the user's favorites.
  /// If it is, it returns true. Otherwise, it returns false.
  bool isDogLiked(String dogId) {
    for (int i = 0; i < user.value.favDogs.length; i++) {
      if (dogId == user.value.favDogs[i]) {
        return true;
      }
    }
    return false;
  }

  /// Toggles the like status of a dog.
  ///
  /// The [dogId] parameter is the ID of the dog to toggle the like status of.
  ///
  /// This method checks if the dog with the given [dogId] is liked by the user using the [isDogLiked] method.
  /// If it is, it removes the dog from the user's favorites using the [dislikeDog] method.
  /// If it is not, it adds the dog to the user's favorites using the [likeDog] method.
  void toggleLikeStatus(String dogId) {
    if (isDogLiked(dogId)) {
      dislikeDog(dogId);
      return;
    }
    likeDog(dogId);
  }

  /// Reserves the current dog and navigates to the individual chat screen.
  ///
  /// This method sets the [isReserved] property of the current dog to true and reserves the dog in the database using the [DogRepository] and [UserRepository] classes.
  /// It also creates a chat between the user and the shelter using the [ChatRepository] class.
  /// Finally, it navigates to the individual chat screen using the [Get.toNamed] method with the [Routes.INDIVIDUAL_CHAT] route.
  void reserveAndContinue() async {
    currentDog().isReserved = true;
    await DogRepository().reserveDog(currentDog().id);
    await UserRepository().addAdoptingDog(user.value.id, currentDog().id);
    await ChatRepository().getOrCreateChat(user.value.id, currentDog());
    Get.toNamed(Routes.INDIVIDUAL_CHAT);
  }

  /// Navigates to the individual chat screen.
  ///
  /// This method creates a chat between the user and the shelter using the [ChatRepository] class.
  /// Finally, it navigates to the individual chat screen using the [Get.toNamed]
  /// method with the [Routes.INDIVIDUAL_CHAT] route and an argument of an empty [Chat] object.
  void navigateToSingleChat() async {
    await ChatRepository().getOrCreateChat(user.value.id, currentDog());
    Get.toNamed(Routes.INDIVIDUAL_CHAT, arguments: Chat.empty());
  }

  /// Navigates back to the dog information screen.
  ///
  /// This method navigates back to the dog information screen using the [Get.toNamed]
  /// method with the [Routes.DOG_INFO] route and the current dog as an argument.
  void navigateBack() {
    Get.toNamed(Routes.DOG_INFO, arguments: currentDog());
  }

  /// Navigates to the shelter profile screen.
  ///
  /// This method navigates to the shelter profile screen using the [Get.toNamed]
  /// method with the [Routes.SHELTER_PROFILE] route.
  void navigateToShelterScreen() {
    Get.toNamed(Routes.SHELTER_PROFILE);
  }
}
