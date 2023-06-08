import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';

import '../../models/dog.dart';

class DogRepository {
  Future<void> uploadDog(Dog dog) async {
    try {
      final CollectionReference dogsCollection =
          FirebaseFirestore.instance.collection('dogs');

      // Create a new document with a generated ID
      final newDogDocRef = dogsCollection.doc();

      // Convert Dog instance to a Map object
      final dogMap = dog.toMap();

      // Upload the dog data to Firestore
      await newDogDocRef.set(dogMap);
      print("dog ${dog.name} crated");
    } catch (e) {
      print('Error uploading dog to Firestore: $e');
    }
  }

  Future<bool> reserveDog(String dogId) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('dogs');
      final userDocRef = usersCollection.doc(dogId);
      await userDocRef.update({
        'isReserved': true,
      });
      print("dog with id $dogId succesfully updated");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> retrieveDogs() async {
    await FirebaseFirestore.instance
        .collection('dogs')
        .get()
        .then((querySnapshot) {
      List<Dog> dogs = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        Dog dog = Dog(
          id: data['id'],
          description: data['description'],
          name: data['name'],
          age: data['age'],
          location: data['location'],
          breed: data['breed'],
          gender: data['gender'],
          isReserved: data['isReserved'],
          mainPictureURL: data['mainPictureURL'],
          shelterID: data['shelterID'],
          size: data['size'],
          friendly: List<String>.from(data['friendly'] ?? []),
          notFriendly: List<String>.from(data['notFriendly'] ?? []),
          healthNegative: List<String>.from(data['healthNegative'] ?? []),
          healthPositive: List<String>.from(data['healthPositive'] ?? []),
          personality: List<String>.from(data['personality'] ?? []),
          pictureURLs: List<String>.from(data['pictureURLs'] ?? []),
        );
        dogs.add(dog);
      }
      DogSingleton().dogs = dogs;
      DogSingleton().dogIndex = 0;
    }).catchError((error) {
      print('Error retrieving shelters: $error');
    });
  }

  Future<RxList<Dog>> fetchShelterDogs(String targetShelterID) async {
    final shelterDogs = <Dog>[].obs;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('dogs')
        .where('shelterID', isEqualTo: targetShelterID)
        .get();

    final dogs = querySnapshot.docs.map((doc) => Dog.fromMap(doc.data())).toList();
    shelterDogs.assignAll(dogs);

    return shelterDogs;
  }


}
