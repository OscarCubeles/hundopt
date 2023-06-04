import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/user_repository.dart';
import 'package:hundopt/models/user.dart';

import '../../shared/services/user_singleton.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    print(email);
    print(password);
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    print(email);
    print(password);
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<HundoptUser?> retrieveUser() async {
    final userManager = UserSingleton();
    if (userManager.userData != null) {
      return userManager.userData;
    }
    final firebaseUser = FirebaseAuth.instance.currentUser;
    HundoptUser user = await UserRepository().getUser(firebaseUser?.uid);
    userManager.userData = user;
    return userManager.userData;
  }

  Future<bool> changeUserEmail(String newEmail, RxnString errText) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      errText.value = e.message!;
      return false;
    }
  }


}