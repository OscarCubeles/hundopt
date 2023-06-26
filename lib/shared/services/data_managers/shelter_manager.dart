import 'package:hundopt/shared/services/data_managers/singletons/shelter_singleton.dart';
import '../../../api/firebase_core/shelter_repository.dart';
import '../../../models/shelter.dart';

/// The [ShelterManager] class provides utility methods for managing shelters.
class ShelterManager {
  /// Returns the current shelter.
  ///
  /// This method returns the current shelter from the `ShelterSingleton` instance.
  Shelter currentShelter() {
    return ShelterSingleton().shelters[ShelterSingleton().shelterIndex];
  }

  /// Sets the current shelter.
  ///
  /// This method sets the current shelter in the `ShelterSingleton` instance based on the given [shelter].
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

  /// Sets the current shelter based on the given [shelterId].
  ///
  /// This method sets the current shelter in the `ShelterSingleton` instance based on the given [shelterId].
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

  /// Retrieves the list of shelters from the server.
  ///
  /// This method retrieves the list of shelters from the server using the `ShelterRepository` class.
  /// If the list of shelters is already available in the `ShelterSingleton` instance, this method does nothing.
  Future<void> retrieveShelters() async {
    if (ShelterSingleton().shelters == []) {
      await ShelterRepository().retrieveShelters();
    }
  }

  /// Sets the list of shelters.
  ///
  /// This method sets the list of shelters in the `ShelterSingleton` instance based on the given [shelterList].
  void setShelters(List<Shelter> shelterList) {
    ShelterSingleton().shelters = shelterList;
  }
}
