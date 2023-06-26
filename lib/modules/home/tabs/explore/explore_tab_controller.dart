import 'dart:async';
import 'package:get/get.dart';
import '../../../../api/firebase_core/firebase_core.dart';
import '../../../../models/model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/services/services.dart';

class ExploreController extends GetxController {
  /// A reactive list of dogs.
  final Rx<List<Dog>> _dogList = Rx<List<Dog>>([]);

  /// A reactive user.
  late Rx<HundoptUser> user = HundoptUser.empty().obs;

  /// An integer representing the index of the current dog.
  int dogIndex = 0;

  /// A getter for the list of dogs.
  List<Dog> get dogList => _dogList.value;

  /// Initializes the controller and retrieves the user, shelters and chats for the user from the DB.
  /// Sets a periodic timer to update teh screen values
  @override
  void onInit() async {
    super.onInit();
    user.value = (await Auth().retrieveUser())!;
    await DogManager().retrieveDogs();
    await ShelterManager().retrieveShelters();
    _dogList.value = DogManager().getDogs();
    setPeriodicUpdate();
  }

  /// Returns the initial page of the explore screen.
  ///
  /// If the dog index is not null, it returns the dog index.
  /// Otherwise, it returns the `dogIndex` variable.
  int initialPage() {
    return DogManager().getDogIndex() == null
        ? dogIndex
        : DogManager().getDogIndex()!;
  }

  /// Sets a periodic update to update the user's information every second.
  void setPeriodicUpdate() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      updateValues();
    });
  }

  /// Toggles the like status of a dog.
  ///
  /// The [dogId] parameter is the id of the dog to toggle the like status.
  /// If the dog is already liked, it calls the [dislikeDog] method.
  /// Otherwise, it calls the [likeDog] method.
  void toggleLikeStatus(String dogId) {
    if (isDogLiked(dogId)) {
      dislikeDog(dogId);
      return;
    }
    likeDog(dogId);
  }

  /// Removes a dog from the user's favorite dogs list.
  ///
  /// The [dogId] parameter is the id of the dog to remove from the user's favorite dogs list.
  /// It removes the dog from the database using the `UserRepository` class and removes it from the `favDogs` list of the user.
  void dislikeDog(String dogId) async {
    await UserRepository().removeFavDog(user.value.id, dogId);
    user.value.favDogs.remove(dogId);
  }

  /// Adds a dog to the user's favorite dogs list.
  ///
  /// The [dogId] parameter is the id of the dog to add to the user's favorite dogs list.
  /// It adds the dog to the database using the `UserRepository` class and adds it to the `favDogs` list of the user.
  void likeDog(String dogId) async {
    await UserRepository().addFavDog(user.value.id, dogId);
    user.value.favDogs.add(dogId);
  }

  /// Checks if a dog is liked by the user.
  ///
  /// The [dogId] parameter is the id of the dog to check if it is liked by the user.
  /// It returns true if the dog is in the `favDogs` list of the user, otherwise, it returns false.
  bool isDogLiked(String dogId) {
    for (int i = 0; i < user.value.favDogs.length; i++) {
      if (dogId == user.value.favDogs[i]) {
        return true;
      }
    }
    return false;
  }

  /// Navigates to the dog info screen.
  ///
  /// The [dog] parameter is the dog to navigate to the dog info screen.
  /// It sets the current dog and shelter based on the given dog using the `DogManager` and `ShelterManager` classes.
  /// Finally, it navigates to the dog info screen using the `Get.toNamed` method with the `Routes.DOG_INFO` route.
  void navigateToDogInfo(Dog dog) {
    DogManager().setCurrentDogByID(dog.id);
    ShelterManager().setCurrentShelterByID(dog.shelterID);
    Get.toNamed(Routes.DOG_INFO);
  }

  /// Updates the user's information by retrieving the current user using the `Auth` class and assigning it to the `user` variable.
  Future<void> updateValues() async {
    user.value = (await Auth().retrieveUser())!;
  }
}
