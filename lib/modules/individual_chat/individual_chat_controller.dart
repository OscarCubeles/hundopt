import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../api/firebase_core/firebase_core.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';
import '../../shared/shared.dart';

class IndividualChatController extends GetxController {
  final ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  Rx<Chat> chat = Chat.empty().obs;
  late HundoptUser user = HundoptUser.empty();
  RxString messageText = RxString("");

  @override
  void onInit() async {
    super.onInit();
    user = (await Auth().retrieveUser())!;
    await DogManager().retrieveDogs();
    await ShelterManager().retrieveShelters();
    chat.value = (await ChatRepository()
        .fetchChatByUserAndDogIDs(user.id, currentDog().id));
    update();
    scrollToBottom();
    setCurrentShelter();
  }

  void messageChanged(String val) {
    messageText.value = val;
  }

  void setCurrentShelter() {
    ShelterManager().setCurrentShelterByID(currentDog().shelterID);
  }

  void addChatMessage() async {
    Message newMsg = Message(
        text: messageText.value, date: DateTime.now().toString(), isUser: true);
    messageText.value = "";
    textEditingController.clear();
    if (chat.value.isEmpty()) {
      chat.value = (await ChatRepository()
          .fetchChatByUserAndDogIDs(user.id, currentDog().id));
    }
    chat.update((val) {
      val?.messages.add(newMsg);
    });
    await ChatRepository().uploadChat(user.id, currentDog().id, chat.value);
    scrollToBottom();
  }

  @override
  void onReady() {
    // scrollToBottom();
  }

  Dog currentDog() {
    return DogManager().currentDog();
  }

  Shelter currentShelter() {
    return ShelterManager().currentShelter();
  }

  void scrollToBottom() {
    if (chat.value.messages.isNotEmpty) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  void navigateToChats() {
    Get.offNamed(Routes.HOME, arguments: 1);
  }

  void navigateToShelter() {
    Get.toNamed(Routes.SHELTER_PROFILE);
  }

  void getToDogInfo() {
    // TODO: Revise if it is necessary to pass the dog
    Get.toNamed(Routes.DOG_INFO, arguments: currentDog());
  }

  String msgDate(String date) {
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
