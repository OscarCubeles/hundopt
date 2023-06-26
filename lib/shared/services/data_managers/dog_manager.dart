import 'package:hundopt/shared/services/data_managers/singletons/dog_singleton.dart';
import '../../../api/firebase_core/dog_repository.dart';
import '../../../models/dog.dart';

/// The [DogManager] class  provides utility methods for managing dogs.
class DogManager {
  /// Returns the current dog.
  ///
  /// This method returns the current dog from the `DogSingleton` instance.
  Dog currentDog() {
    return DogSingleton().dogs![DogSingleton().dogIndex!];
  }

  /// Retrieves the list of dogs from the server.
  ///
  /// This method retrieves the list of dogs from the server using the `DogRepository` class.
  /// If the list of dogs is already available in the `DogSingleton` instance, this method does nothing.
  Future<void> retrieveDogs() async {
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
  }

  /// Returns the list of dogs.
  ///
  /// This method returns the list of dogs from the `DogSingleton` instance.
  List<Dog> getDogs() {
    return DogSingleton().dogs!;
  }

  /// Sets the current dog.
  ///
  /// This method sets the current dog in the `DogSingleton` instance based on the given [dog].
  void setCurrentDog(Dog dog) {
    int i = 0;
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (dog.id == tmpDog.id) {
        DogSingleton().dogIndex = i;
        break;
      }
      i++;
    }
  }

  /// Sets the current dog based on the given [dogId].
  ///
  /// This method sets the current dog in the `DogSingleton` instance based on the given [dogId].
  void setCurrentDogByID(String dogId) {
    int i = 0;
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (dogId == tmpDog.id) {
        DogSingleton().dogIndex = i;
        break;
      }
      i++;
    }
  }

  /// Returns the URL of the main picture of the dog with the given [dogId].
  ///
  /// This method returns the URL of the main picture of the dog with the given [dogId] from the `DogSingleton` instance.
  String getDogPictureURL(String dogId) {
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (tmpDog.id == dogId) {
        return tmpDog.mainPictureURL;
      }
    }
    return "";
  }

  /// Returns the name of the dog with the given [dogId].
  ///
  /// This method returns the name of the dog with the given [dogId] from the `DogSingleton` instance.
  String getDogNameById(String dogId) {
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (tmpDog.id == dogId) {
        return tmpDog.name;
      }
    }
    return "";
  }

  /// Sets the initial list of dogs.
  ///
  /// This method sets the initial list of dogs in the `DogSingleton` instance based on the given [dogs].
  void setInitialDogs(List<Dog> dogs) {
    DogSingleton().dogs = dogs;
    DogSingleton().dogIndex = 0;
  }

  /// Returns the index of the current dog.
  ///
  /// This method returns the index of the current dog from the `DogSingleton` instance.
  int? getDogIndex() {
    return DogSingleton().dogIndex;
  }

  /// Sets the index of the current dog.
  ///
  /// This method sets the index of the current dog in the `DogSingleton` instance based on the given [index].
  void setDogIndex(int index) {
    DogSingleton().dogIndex = index;
  }
}
