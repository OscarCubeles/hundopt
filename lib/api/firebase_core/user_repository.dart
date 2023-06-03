import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user.dart';

class UserRepository {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(String username, String email, String userID) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');
      // Create a new document with a generated ID
      final newUserDocRef = usersCollection.doc(userID);
      // Set the data for the new user document
      await newUserDocRef.set({
        'username': username,
        'fullname': '',
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

  Future<HundoptUser> getUser(String? userId) async {
    try {
      final userDoc = await usersCollection.doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        return HundoptUser.fromJson(userData);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Error retrieving user from Firestore: $e');
      rethrow;
    }
  }
}
