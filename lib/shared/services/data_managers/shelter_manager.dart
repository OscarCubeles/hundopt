import 'package:hundopt/shared/services/data_managers/singletons/shelter_singleton.dart';
import '../../../api/firebase_core/shelter_repository.dart';
import '../../../models/shelter.dart';

class ShelterManager{
  Shelter currentShelter(){
    return ShelterSingleton().shelters[ShelterSingleton().shelterIndex];
  }

  void setCurrentShelter(Shelter shelter) {
    int i = 0;
    for (Shelter tmpShelter in ShelterSingleton().shelters) {
      if (shelter.id == tmpShelter.id) {
        ShelterSingleton().shelterIndex = i;
        break;
      }
      i++;
    }
  }

  void setCurrentShelterByID(String shelterId) {
    int i = 0;
    for (Shelter tmpShelter in ShelterSingleton().shelters) {
      if (shelterId == tmpShelter.id) {
        ShelterSingleton().shelterIndex = i;
        break;
      }
      i++;
    }
  }

  Future<void> retrieveShelters() async {
    if (ShelterSingleton().shelters == []) {
      await ShelterRepository().retrieveShelters();
    }
  }

  void setShelters(List<Shelter> shelterList){
    ShelterSingleton().shelters = shelterList;
  }



}