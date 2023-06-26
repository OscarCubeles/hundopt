import '../../../../models/user.dart';

/// The [UserSingleton] class stores the current user.
class UserSingleton {
  /// The instance of the `UserSingleton` class.
  static final UserSingleton _instance = UserSingleton._internal();

  /// Returns the instance of the `UserSingleton` class.
  factory UserSingleton() => _instance;

  /// The current user.
  HundoptUser? userData;

  /// Private constructor for the `UserSingleton` class.
  UserSingleton._internal();
}
