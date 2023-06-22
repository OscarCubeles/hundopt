import 'package:hundopt/models/model.dart';
import 'package:hundopt/shared/services/data_managers/singletons/user_singleton.dart';

class UserManager{
  void setUser(HundoptUser user){
    UserSingleton().userData = user;
  }

  HundoptUser? getUser(){
    return UserSingleton().userData;
  }
}