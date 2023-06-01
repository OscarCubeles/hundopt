import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user.dart';

class UserRepository {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');
  Future<void> createUser(String username, String email, String userID) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');

      // Create a new document with a generated ID
      final newUserDocRef = usersCollection.doc();

      // Set the data for the new user document
      await newUserDocRef.set({
        'username': username,
        'email': email,
        'adoptingDogs': [],
        'id': userID,
        'phone': "",
        'personalityFormID': "",
        'pictureURL': ""
      });
    } catch (e) {
      print('Error creating user in Firestore: $e');
    }
  }
}
