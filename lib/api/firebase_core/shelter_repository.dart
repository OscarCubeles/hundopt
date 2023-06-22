import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hundopt/shared/services/data_managers/shelter_manager.dart';
import '../../models/shelter.dart';
import '../../models/user.dart';

///  The [ShelterRepository] class provides methods for managing personality form documents in Firestore.
class ShelterRepository {

  /// Retrieves all shelters from Firestore.
  ///
  /// Returns a [Future] that completes with the list of retrieved shelters.
  ///
  /// The retrieved shelters are stored in the [ShelterManager] for easy access.
  Future<void> retrieveShelters() async {
    await FirebaseFirestore.instance
        .collection('shelters')
        .get()
        .then((querySnapshot) {
      List<Shelter> shelters = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        Shelter shelter = Shelter(
          id: doc.id,
          name: data['name'],
          email: data['email'],
          phone: data['phone'],
          location: data['location'],
          pictureURL: data['pictureURL'],
          dogsId: List<String>.from(data['dogs-id'] ?? []),
          facebook: data['facebook'],
          tiktok: data['tiktok'],
          twitter: data['twitter'],
          linkedin: data['linkedin'],
        );
        shelters.add(shelter);
      }
      ShelterManager().setShelters(shelters);
    }).catchError((error) {
      print('Error retrieving shelters: $error');
    });
  }

  /// Fetches the favorite shelters of a user from Firestore.
  ///
  /// The [user] parameter represents the user for whom to fetch favorite shelters.
  ///
  /// Returns a [Future] that completes with a reactive list of favorite shelters.
  Future<RxList<Shelter>> fetchFavShelters(HundoptUser user) async {
    final favShelters = <Shelter>[].obs;
    for (final shelterId in user.favShelters) {
      final shelterSnapshot = await FirebaseFirestore.instance
          .collection('shelters')
          .doc(shelterId)
          .get();
      if (shelterSnapshot.exists) {
        final shelterData = shelterSnapshot.data() as Map<String, dynamic>;
        final shelter = Shelter.fromMap(shelterData);
        favShelters.add(shelter);
      }
    }
    return favShelters;
  }
}
