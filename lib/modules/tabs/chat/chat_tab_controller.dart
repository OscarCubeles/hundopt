import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/chat_repository.dart';
import 'package:hundopt/shared/constants/constants.dart';
import 'package:hundopt/shared/services/dog_singleton.dart';
import 'package:intl/intl.dart';

import '../../../api/firebase_core/auth.dart';
import '../../../models/chat.dart';
import '../../../models/dog.dart';
import '../../../models/old_chat.dart';
import '../../../models/user.dart';

class ChatController extends GetxController {
  var chatList = <OldChat>[].obs;
  RxList userChats = [].obs;
  late HundoptUser user = HundoptUser.empty();

  @override
  void onInit() async {
    super.onInit();
    user = (await Auth().retrieveUser())!;
    //userChats = await ChatRepository().fetchUserChats(user.id);
    userChats.assignAll(await ChatRepository().fetchUserChats(user.id));
    update();
    initChats();
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

  void initChats() {
    addChat(OldChat(
      name: 'TestDog3',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6yiGZN_wWoSRP4BfKxvubTLJlVXWQcsFrolaA8_INriWYk8RokDPac2QLI6jTBfr97WI&usqp=CAU",
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(OldChat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          "https://upload.wikimedia.org/wikipedia/commons/6/60/YellowLabradorLooking.jpg",
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(OldChat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(OldChat(
      name: 'TestDog',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
    ));
    addChat(OldChat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime(DateTime.now().year,
          DateTime.now().month - 3, DateTime.now().day - 1),
    ));
    addChat(OldChat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(OldChat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(OldChat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime.now(),
    ));
  }

  void addChat(OldChat chat) {
    chatList.add(chat);
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
