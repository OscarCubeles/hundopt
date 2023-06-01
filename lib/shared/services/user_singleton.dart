import '../../models/user.dart';

class UserSingleton {
  static UserSingleton? _instance;
  User user;

  factory UserSingleton(User user) {
    _instance ??= UserSingleton._internal(user);
    return _instance!;
  }

  UserSingleton._internal(this.user);

}
