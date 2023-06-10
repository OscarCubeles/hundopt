import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../models/shelter.dart';
import '../../models/user.dart';
import '../../shared/services/shelter_singleton.dart';

class ShelterRepository{
  Future<void> retrieveShelters() async {
    await FirebaseFirestore.instance.collection('shelters').get().then((querySnapshot) {
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
          dogsId: List<String>.from(data['dogs-id'] ?? []),//TODO: CHeck why social networks do not appear
          facebook: data['facebook'],
          tiktok: data['tiktok'],
          twitter: data['twitter'],
          linkedin: data['linkedin'],
        );
        shelters.add(shelter);
      }
      ShelterSingleton().shelters = shelters;
    }).catchError((error) {
      print('Error retrieving shelters: $error');
    });
  }

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