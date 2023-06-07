import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/shelter.dart';
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
          dogsId: List<String>.from(data['dogsId'] ?? []),
          socialNetworks: List<String>.from(data['socialNetworks'] ?? []),
        );
        shelters.add(shelter);
      }
      ShelterSingleton().shelters = shelters;
    }).catchError((error) {
      print('Error retrieving shelters: $error');
    });
  }
}