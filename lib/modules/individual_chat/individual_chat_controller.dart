import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../api/firebase_core/firebase_core.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';
import '../../shared/shared.dart';

/// The [IndividualChatController] manages all data and actions for an Individual Chat screen.
class IndividualChatController extends GetxController {
  /// A scroll controller for the chat messages.
  final ScrollController scrollController = ScrollController();

  /// A text editing controller for the chat input.
  TextEditingController textEditingController = TextEditingController();

  /// A reactive chat.
  Rx<Chat> chat = Chat.empty().obs;

  /// A user.
  late HundoptUser user = HundoptUser.empty();

  /// A reactive string representing the message text.
  RxString messageText = RxString("");

  /// Gathers the user, dogs and shelters needed to display all the corresponding
  /// information in an individual chat screen. Additionally scrolls down the chat to
  /// the last message
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

  /// Updates the message text.
  ///
  /// The [val] parameter is the new value of the message text.
  void messageChanged(String val) {
    messageText.value = val;
  }

  /// Sets the current shelter.
  void setCurrentShelter() {
    ShelterManager().setCurrentShelterByID(currentDog().shelterID);
  }

  /// Adds a chat message.
  ///
  /// It creates a new message with the message text and adds it to the chat messages.
  /// It then uploads the chat to the database and scrolls to the bottom of the chat messages.
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

  /// Returns the current dog.
  Dog currentDog() {
    return DogManager().currentDog();
  }

  /// Returns the current shelter.
  Shelter currentShelter() {
    return ShelterManager().currentShelter();
  }

  /// Scrolls to the bottom of the chat messages.
  void scrollToBottom() {
    if (chat.value.messages.isNotEmpty) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  /// Navigates to the chats screen.
  void navigateToChats() {
    Get.offNamed(Routes.HOME, arguments: 1);
  }

  /// Navigates to the shelter profile screen.
  void navigateToShelter() {
    Get.toNamed(Routes.SHELTER_PROFILE);
  }

  /// Navigates to the dog info screen.
  void getToDogInfo() {
    Get.toNamed(Routes.DOG_INFO);
  }

  /// Returns the formatted date of the message.
  ///
  /// The [date] parameter is the date of the message.
  String msgDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    if (DateFormatter().isToday(dateTime)) {
      return DateFormatter().formatHour(dateTime);
    } else if (DateFormatter().isYesterday(dateTime)) {
      return StringConstants.yesterdayLabel;
    } else {
      return DateFormatter().formatDate(dateTime);
    }
  }
}
