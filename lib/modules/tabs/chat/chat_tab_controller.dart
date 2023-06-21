import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/chat_repository.dart';
import 'package:hundopt/shared/constants/constants.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';
import 'package:hundopt/shared/utils/date_formatter.dart';

import '../../../api/firebase_core/auth.dart';
import '../../../api/firebase_core/shelter_repository.dart';
import '../../../models/chat.dart';
import '../../../models/dog.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/services/shelter_singleton.dart';

class ChatController extends GetxController {
  RxList userChats = [].obs;
  late HundoptUser user = HundoptUser.empty();

  @override
  void onInit() async {
    super.onInit();
    user = (await Auth().retrieveUser())!;
    userChats.assignAll(await ChatRepository().fetchUserChats(user.id));
    if (ShelterSingleton().shelters == []) {
      await ShelterRepository().retrieveShelters();
    }
    update();
  }

  void retrieveShelter(int index) {
    for (int i = 0; i < ShelterSingleton().shelters.length; i++) {
      if (ShelterSingleton().shelters[i].id == userChats[index].shelterID) {
        ShelterSingleton().shelterIndex = i;
        print(ShelterSingleton().shelters[i].name);
        return;
      }
    }
  }

  void navigateToSingleChat(int chatIndex) {
    retrieveShelter(chatIndex);
    // TODO: Add this method in the service that uses the singleton, the service could be called dogmanager
    int i = 0;
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (userChats[chatIndex].dogID == tmpDog.id) {
        DogSingleton().dogIndex = i;
        Get.offNamed(Routes.INDIVIDUAL_CHAT, arguments: userChats[chatIndex]);
        break;
      }
      i++;
    }
  }

  Widget chatSeparator(int index) {
    return (index + 1) < userChats.length
        ? Container(
            height: 0.15,
            color: ColorConstants.appGrey,
          )
        : Container();
  }

  String chatPictureURL(Chat chat) {
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (tmpDog.id == chat.dogID) {
        return tmpDog.mainPictureURL;
      }
    }
    return "";
  }

  String chatName(Chat chat) {
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (tmpDog.id == chat.dogID) {
        return tmpDog.name;
      }
    }
    return "";
  }

  String lastMsg(Chat chat) {
    return chat.messages.isNotEmpty
        ? chat.messages[chat.messages.length - 1].text
        : "";
  }

  String msgDate(String date) {
    if(date.isEmpty) return "";
    DateTime dateTime = DateTime.parse(date);
    // Get the current date and time
    if (DateFormatter().isToday(dateTime)) {
      return DateFormatter().formatHour(dateTime);
    } else if (DateFormatter().isYesterday(dateTime)) {
      return 'Ayer';
    } else {
      return DateFormatter().formatDate(dateTime);
    }
  }
}
