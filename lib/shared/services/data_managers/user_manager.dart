import 'package:hundopt/models/model.dart';
import 'package:hundopt/shared/services/data_managers/singletons/user_singleton.dart';

/// The [UserManager] class provides utility methods for managing the current user.
class UserManager {
  /// Sets the current user.
  ///
  /// This method sets the current user in the `UserSingleton` instance based on the given [user].
  void setUser(HundoptUser user) {
    UserSingleton().userData = user;
  }

  /// Returns the current user.
  ///
  /// This method returns the current user from the `UserSingleton` instance.
  HundoptUser? getUser() {
    return UserSingleton().userData;
  }
}
