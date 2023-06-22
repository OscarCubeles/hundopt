import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user.dart';

///  The [UserRepository] class provides methods for managing personality form documents in Firestore.
class UserRepository {
  /// Collection reference to the 'users' collection in Firestore.
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  /// Creates a new user in Firestore.
  ///
  /// The [username], [email], [userID], and [pwd] parameters represent the user's
  /// username, email, unique user ID, and password, respectively.
  ///
  /// Throws an error if there's an issue creating the user in Firestore.
  Future<void> createUser(
      String username, String email, String userID, String pwd) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');
      final newUserDocRef = usersCollection.doc(userID);
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

  /// Retrieves a user from Firestore.
  ///
  /// The [userId] parameter represents the ID of the user to retrieve.
  ///
  /// Returns a [Future] that completes with the retrieved [HundoptUser] object if
  /// the user is found.
  ///
  /// Throws an exception if the user is not found.
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

  /// Updates a user's information in Firestore.
  ///
  /// The [email], [phone], and [username] parameters represent the new email,
  /// phone number, and username of the user, respectively.
  ///
  /// The [errText] parameter is a reactive string that holds any error message.
  ///
  /// Returns `true` if the update is successful, and `false` otherwise.
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

  /// Adds a dog to a user's favorite dogs list in Firestore.
  ///
  /// The [userId] parameter represents the ID of the user.
  /// The [dogId] parameter represents the ID of the dog to be added.
  ///
  /// Throws an error if there's an issue adding the dog to the favorite dogs list.
  Future addFavDog(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'favDogs': FieldValue.arrayUnion([dogId])
    }).then((value) {
      print('Dog added to favorites successfully!');
    }).catchError((error) {
      print('Failed to add dog to favorites: $error');
    });
  }

  /// Removes a dog from a user's favorite dogs list in Firestore.
  ///
  /// The [userId] parameter represents the ID of the user.
  /// The [dogId] parameter represents the ID of the dog to be removed.
  ///
  /// Throws an error if there's an issue removing the dog from the favorite dogs list.
  Future removeFavDog(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'favDogs': FieldValue.arrayRemove([dogId])
    }).then((value) {
      print('Dog removed from favorites successfully!');
    }).catchError((error) {
      print('Failed to remove dog from favorites: $error');
    });
  }

  /// Adds a shelter to a user's favorite shelters list in Firestore.
  ///
  /// The [userId] parameter represents the ID of the user.
  /// The [dogId] parameter represents the ID of the shelter to be added.
  ///
  /// Throws an error if there's an issue adding the shelter to the favorite shelters list.
  Future addFavShelter(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'favShelters': FieldValue.arrayUnion([dogId])
    }).then((value) {
      print('Shelter added to favorites successfully!');
    }).catchError((error) {
      print('Failed to add shelter to favorites: $error');
    });
  }

  /// Removes a shelter from a user's favorite shelters list in Firestore.
  ///
  /// The [userId] parameter represents the ID of the user.
  /// The [dogId] parameter represents the ID of the shelter to be removed.
  ///
  /// Throws an error if there's an issue removing the shelter from the favorite shelters list.
  Future removeFavShelter(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'favShelters': FieldValue.arrayRemove([dogId])
    }).then((value) {
      print('Shelter removed from favorites successfully!');
    }).catchError((error) {
      print('Failed to remove shelter from favorites: $error');
    });
  }

  /// Uploads an image to Firebase Storage.
  ///
  /// Allows the user to select an image from the gallery.
  ///
  /// Returns a [Future] that completes with the uploaded image URL if successful,
  /// and `null` otherwise.
  Future<String?> uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance.ref().child('images');
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      if (snapshot.state == TaskState.success) {
        final imageUrl = await snapshot.ref.getDownloadURL();
        return imageUrl;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  /// Updates the picture URL of a user in Firestore.
  ///
  /// The [userId] parameter represents the ID of the user.
  /// The [pictureURL] parameter represents the new picture URL to be set.
  ///
  /// Throws an error if there's an issue updating the picture URL.
  Future<void> updatePictureURL(String userId, String pictureURL) async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({
        'pictureURL': pictureURL,
      });
    } catch (e) {
      print('Failed to update Picture URL: $e');
      // Handle the error as needed
    }
  }

  /// Adds a dog to a user's adopting dogs list in Firestore.
  ///
  /// The [userId] parameter represents the ID of the user.
  /// The [dogId] parameter represents the ID of the dog to be added.
  ///
  /// Throws an error if there's an issue adding the dog to the adopting dogs list.
  Future addAdoptingDog(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'adoptingDogs': FieldValue.arrayUnion([dogId])
    }).then((value) {
      print('Dog added addopting dog successfully!');
    }).catchError((error) {
      print('Failed to add dog to favorites: $error');
    });
  }

  /// Removes a dog from a user's adopting dogs list in Firestore.
  ///
  /// The [userId] parameter represents the ID of the user.
  /// The [dogId] parameter represents the ID of the dog to be removed.
  ///
  /// Throws an error if there's an issue removing the dog from the adopting dogs list.
  Future removeAdoptingDog(String userId, String dogId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'adoptingDogs': FieldValue.arrayRemove([dogId])
    }).then((value) {
      print('Dog removed from favorites successfully!');
    }).catchError((error) {
      print('Failed to remove dog from favorites: $error');
    });
  }
}
