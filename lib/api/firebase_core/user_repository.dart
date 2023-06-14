import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../models/user.dart';

class UserRepository {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(
      String username, String email, String userID, String pwd) async {
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
        'favDogs': [],
        'favShelters': [],
        'id': userID,
        'phone': "",
        'personalityFormID': "",
        'pictureURL': "pwd:$pwd"
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

  Future<bool> updateUser(
      String email, String phone, String username, RxnString errText) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final usersCollection = FirebaseFirestore.instance.collection('users');
      final userDocRef = usersCollection.doc(user?.uid);
      await userDocRef.update({
        'email': email,
        'phone': phone,
        'username': username,
      });
      return true;
    } catch (e) {
      errText.value = e.toString();
      return false;
    }
  }

  Future addFavDog(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'favDogs': FieldValue.arrayUnion([dogId])
    }).then((value) {
      print('Dog added to favorites successfully!');
    }).catchError((error) {
      print('Failed to add dog to favorites: $error');
    });
  }

  Future removeFavDog(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'favDogs': FieldValue.arrayRemove([dogId])
    }).then((value) {
      print('Dog removed from favorites successfully!');
    }).catchError((error) {
      print('Failed to remove dog from favorites: $error');
    });
  }

  Future addFavShelter(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'favShelters': FieldValue.arrayUnion([dogId])
    }).then((value) {
      print('Shelter added to favorites successfully!');
    }).catchError((error) {
      print('Failed to add shelter to favorites: $error');
    });
  }

  Future removeFavShelter(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'favShelters': FieldValue.arrayRemove([dogId])
    }).then((value) {
      print('Shelter removed from favorites successfully!');
    }).catchError((error) {
      print('Failed to remove shelter from favorites: $error');
    });
  }

}
