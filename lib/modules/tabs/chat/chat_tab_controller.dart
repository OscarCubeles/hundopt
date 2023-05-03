import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/constants/constants.dart';
import 'package:intl/intl.dart';

import '../../../models/chat.dart';

class ChatController extends GetxController {
  var chatList = <Chat>[].obs;

  @override
  void onInit() {
    super.onInit();
    initChats();
  }

  void initChats() {
    addChat(Chat(
      name: 'TestDog3',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6yiGZN_wWoSRP4BfKxvubTLJlVXWQcsFrolaA8_INriWYk8RokDPac2QLI6jTBfr97WI&usqp=CAU",
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(Chat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          "https://upload.wikimedia.org/wikipedia/commons/6/60/YellowLabradorLooking.jpg",
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(Chat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(Chat(
      name: 'TestDog',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
    ));
    addChat(Chat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime(DateTime.now().year,
          DateTime.now().month - 3, DateTime.now().day - 1),
    ));
    addChat(Chat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(Chat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(Chat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl:
          'https://img.rawpixel.com/private/static/images/website/2022-05/ns8230-image.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=b3961e17298745c0868eeef46211c3d0',
      lastMessageReceivedTime: DateTime.now(),
    ));
  }

  void addChat(Chat chat) {
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
