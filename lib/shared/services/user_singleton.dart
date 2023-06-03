import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();
  factory UserSingleton() => _instance;

  HundoptUser? userData;

  UserSingleton._internal();

}
