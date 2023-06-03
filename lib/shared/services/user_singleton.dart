import '../../models/user.dart';

class UserSingleton {
  static UserSingleton? _instance;
  HundoptUser user;

  factory UserSingleton(HundoptUser user) {
    _instance ??= UserSingleton._internal(user);
    return _instance!;
  }

  UserSingleton._internal(this.user);

}
