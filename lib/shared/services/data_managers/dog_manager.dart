import 'package:hundopt/shared/services/data_managers/singletons/dog_singleton.dart';
import '../../../api/firebase_core/dog_repository.dart';
import '../../../models/dog.dart';

class DogManager {

  Dog currentDog() {
    return DogSingleton().dogs![DogSingleton().dogIndex!];
  }

  Future<void> retrieveDogs()async {
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
  }

  List<Dog> getDogs(){
    return DogSingleton().dogs!;
  }

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

  String getDogPictureURL(String dogId) {
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (tmpDog.id == dogId) {
        return tmpDog.mainPictureURL;
      }
    }
    return "";
  }

  String getDogNameById(String dogId) {
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (tmpDog.id == dogId) {
        return tmpDog.name;
      }
    }
    return "";
  }

  void setInitialDogs(List<Dog> dogs){
    DogSingleton().dogs = dogs;
    DogSingleton().dogIndex = 0;
  }

  int? getDogIndex(){
    return DogSingleton().dogIndex;
  }

  void setDogIndex(int index){
    DogSingleton().dogIndex = index;
  }



}