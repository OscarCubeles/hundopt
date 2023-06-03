import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/user_repository.dart';
import 'package:hundopt/shared/constants/constants.dart';
import 'package:intl/intl.dart';

import '../../../models/chat.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/services/user_singleton.dart';

class ProfileController extends GetxController {

  RxString username = RxString('');
  RxString fullName = RxString('');
  late UserSingleton userSingleton; // Declare UserSingleton variable


  @override
  void onInit() {
    super.onInit();

    retrieveUser();

  }

  void retrieveUser() async{
    final firebaseUser = FirebaseAuth.instance.currentUser;
    HundoptUser user = await UserRepository().getUser(firebaseUser?.uid);
    setScreenValues(user);
  }

  void setScreenValues(HundoptUser hundoptUser){
    username.value = '@${hundoptUser.username}';
    fullName.value = hundoptUser.fullName;
    print(username);
    print(fullName);
    update();
  }

  void onSettingsPressed(){
    Get.offNamed(Routes.SETTINGS, arguments: this);
  }

}
