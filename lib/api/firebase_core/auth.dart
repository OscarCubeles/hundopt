import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/user_repository.dart';
import 'package:hundopt/models/user.dart';
import 'package:hundopt/shared/services/data_managers/data_managers.dart';

/// The [Auth] class provides methods for user authentication and access to user-related information.
class Auth {
  /// An instance of the [FirebaseAuth] class used for authentication operations.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Returns the currently authenticated user, or `null` if there is no authenticated user.
  User? get currentUser => _firebaseAuth.currentUser;

  /// A stream that emits changes in the authentication state, such as when a user signs in or signs out.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Sends a password reset email to the user associated with the provided [email]. The user will receive an email containing instructions to reset their password.
  ///
  /// Parameters:
  /// - [email]: The email address of the user.
  ///
  /// Throws a [FirebaseAuthException] if an error occurs while sending the password reset email.
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// Signs in the user with the provided [email] and [password].
  ///
  /// This method is used to authenticate the user by their email and password. It attempts to sign in the user using the provided credentials.
  ///
  /// Parameters:
  /// - [email]: The email address of the user.
  /// - [password]: The password of the user.
  ///
  /// Throws a [FirebaseAuthException] if an error occurs while signing in.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Creates a new user account with the provided [email] and [password].
  ///
  /// This method is used to create a new user account using the provided email and password.
  /// It attempts to create a new user account with the provided credentials.
  ///
  /// Throws a [FirebaseAuthException] if an error occurs while creating the user account.
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs out the currently authenticated user.
  ///
  /// This method is used to sign out the currently authenticated user.
  /// It terminates the user's session and clears any cached credentials.
  ///
  /// Throws a [FirebaseAuthException] if an error occurs while signing out.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Retrieves the user data.
  ///
  /// This method retrieves the user data either from the local cache or from the Firebase backend if it is not available locally.
  /// If the user data is found in the local cache, it is returned immediately.
  /// Otherwise, the method fetches the user data from Firebase using the user's unique ID obtained from the current authenticated user.
  /// The retrieved user data is then stored in the local cache for future use.
  ///
  /// Returns the user data if it exists, otherwise returns null.
  Future<HundoptUser?> retrieveUser() async {
    if (UserManager().getUser() != null) {
      return UserManager().getUser();
    }
    final firebaseUser = FirebaseAuth.instance.currentUser;
    HundoptUser user = await UserRepository().getUser(firebaseUser?.uid);
    UserManager().setUser(user);
    return UserManager().getUser();
  }

  /// Forces the retrieval of user data.
  ///
  /// This method retrieves the user data from the Firebase backend using the user's unique ID obtained from the current authenticated user.
  /// The retrieved user data is then stored in the local cache for future use.
  ///
  /// Returns the user data if it exists, otherwise returns null.
  Future<HundoptUser?> forceRetrieveUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    HundoptUser user = await UserRepository().getUser(firebaseUser?.uid);
    UserManager().setUser(user);
    return UserManager().getUser();
  }

  /// Changes the user's email.
  ///
  /// This method updates the email address of the current authenticated user with the provided [newEmail].
  /// If the operation is successful, it returns `true`; otherwise, it returns `false`.
  /// In case of an error, the [errText] parameter is updated with the error message.
  ///
  /// Returns `true` if the email was successfully changed, `false` otherwise.
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
