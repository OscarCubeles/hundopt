import 'package:get/get.dart';

import '../../../models/chat.dart';

class ChatController extends GetxController {
  var chatList = <Chat>[].obs;

  void addChat(Chat chat) {
    chatList.add(chat);
  }

  @override
  void onInit() {
    super.onInit();

    addChat(Chat(
      name: 'TestDog3',
      lastMessage: 'Esta disponible?',
      pictureUrl:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6yiGZN_wWoSRP4BfKxvubTLJlVXWQcsFrolaA8_INriWYk8RokDPac2QLI6jTBfr97WI&usqp=CAU",
      lastMessageReceivedTime: DateTime.now(),
    ));
    addChat(Chat(
      name: 'TestDog2',
      lastMessage: 'Esta disponible?',
      pictureUrl: "https://upload.wikimedia.org/wikipedia/commons/6/60/YellowLabradorLooking.jpg",
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
}
