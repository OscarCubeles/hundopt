import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/chat_repository.dart';
import 'package:hundopt/shared/constants/constants.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';
import 'package:intl/intl.dart';

import '../../../api/firebase_core/auth.dart';
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
    update();
  }

  void retrieveShelter() {
    for (int i = 0; i < ShelterSingleton().shelters.length; i++) {
      if (ShelterSingleton().shelters[i].id ==
          DogSingleton().dogs![DogSingleton().dogIndex!].shelterID) {
        ShelterSingleton().shelterIndex = i;
        print(ShelterSingleton().shelters[i].name);
        return;
      }
    }
  }

  void navigateToSingleChat(int chatIndex) {
    retrieveShelter();
    // TODO: Add this method in the service that uses the singleton, the service could be called dogmanager
    int i = 0;
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (userChats[chatIndex].dogID == tmpDog.id) {
        DogSingleton().dogIndex = i;
        Get.toNamed(Routes.INDIVIDUAL_CHAT, arguments: userChats[chatIndex]);
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
    return chat.messages[chat.messages.length - 1].text;
  }

  bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return dateTime.day == today.day &&
        dateTime.year == today.year &&
        dateTime.month == today.month;
  }

  bool isYesterday(DateTime dateTime) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return dateTime.day == yesterday.day &&
        dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month;
  }

  Widget getChatDate(DateTime dateTime, TextStyle style) {
    String formattedDate;
    if (isToday(dateTime)) {
      formattedDate = DateFormat('h:mm a').format(dateTime);
    } else if (isYesterday(dateTime)) {
      formattedDate = StringConstants.yesterdayLabel;
    } else {
      formattedDate = DateFormat('d/M/yy').format(dateTime);
    }
    return Text(
      formattedDate,
      style: style,
      overflow: TextOverflow.ellipsis,
    );
  }
}
