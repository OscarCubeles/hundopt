import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hundopt/models/user.dart';
import 'package:hundopt/shared/services/data_managers/dog_manager.dart';
import '../../models/dog.dart';

///  The [DogRepository] class provides methods for managing dogs documents in Firestore.
class DogRepository {
  /// Uploads a dog to Firestore.
  ///
  /// The [dog] parameter represents the dog object to be uploaded.
  ///
  /// Throws an error if the upload fails.
  Future<void> uploadDog(Dog dog) async {
    try {
      final CollectionReference dogsCollection =
          FirebaseFirestore.instance.collection('dogs');
      final newDogDocRef = dogsCollection.doc();
      final dogMap = dog.toMap();
      await newDogDocRef.set(dogMap);
    } catch (e) {
      print('Error uploading dog to Firestore: $e');
    }
  }

  /// Reserves a dog in Firestore.
  ///
  /// The [dogId] parameter represents the ID of the dog to be reserved.
  ///
  /// Returns `true` if the reservation is successful, `false` otherwise.
  Future<bool> reserveDog(String dogId) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('dogs');
      final userDocRef = usersCollection.doc(dogId);
      await userDocRef.update({
        'isReserved': true,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Retrieves all dogs from Firestore.
  ///
  /// Fetches the list of dogs from the Firestore collection 'dogs' and converts them into Dog objects.
  /// The retrieved dogs are then assigned to the DogManager's initial dogs list.
  ///
  /// Throws an error if the retrieval fails.
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
      DogManager().setInitialDogs(dogs);
    }).catchError((error) {
      print('Error retrieving shelters: $error');
    });
  }

  /// Fetches all dogs associated with a specific shelter.
  ///
  /// The [targetShelterID] parameter represents the ID of the target shelter.
  ///
  /// Returns a [RxList<Dog>] that emits the list of shelter dogs.
  Future<RxList<Dog>> fetchShelterDogs(String targetShelterID) async {
    final shelterDogs = <Dog>[].obs;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('dogs')
        .where('shelterID', isEqualTo: targetShelterID)
        .get();
    final dogs =
        querySnapshot.docs.map((doc) => Dog.fromMap(doc.data())).toList();
    shelterDogs.assignAll(dogs);
    return shelterDogs;
  }

  /// Fetches all dogs that a user is adopting.
  ///
  /// The [user] parameter represents the user object.
  ///
  /// Returns a [RxList<Dog>] that emits the list of adopting dogs.
  Future<RxList<Dog>> fetchAdoptingDogs(HundoptUser user) async {
    final adoptingDogs = <Dog>[].obs;
    for (final dogId in user.adoptingDogs) {
      final dogSnapshot =
          await FirebaseFirestore.instance.collection('dogs').doc(dogId).get();
      if (dogSnapshot.exists) {
        final dogData = dogSnapshot.data() as Map<String, dynamic>;
        final dog = Dog.fromMap(dogData);
        adoptingDogs.add(dog);
      }
    }
    return adoptingDogs;
  }

  /// Fetches all favorite dogs of a user.
  ///
  /// The [user] represents the user object.
  ///
  /// Returns a [RxList<Dog>] that emits the list of favorite dogs.
  Future<RxList<Dog>> fetchFavDogs(HundoptUser user) async {
    final favDogs = <Dog>[].obs;
    for (final dogId in user.favDogs) {
      final dogSnapshot =
          await FirebaseFirestore.instance.collection('dogs').doc(dogId).get();
      if (dogSnapshot.exists) {
        final dogData = dogSnapshot.data() as Map<String, dynamic>;
        final dog = Dog.fromMap(dogData);
        favDogs.add(dog);
      }
    }
    return favDogs;
  }
}
