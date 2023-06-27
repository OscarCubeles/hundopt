import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../api/firebase_core/firebase_core.dart';
import '../../../../models/model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/shared.dart';

/// The [ChatController] manages the state of the chat tab screen with all user chats.
class ChatController extends GetxController {
  /// The reactive list of chats for the current user
  RxList userChats = [].obs;

  /// The current user.
  late HundoptUser user = HundoptUser.empty();

  /// Initializes the controller and retrieves the user, shelters and chats for the user from the DB.
  @override
  void onInit() async {
    super.onInit();
    user = (await Auth().retrieveUser())!;
    userChats.assignAll(await ChatRepository().fetchUserChats(user.id));
    await ShelterManager().retrieveShelters();
    update();
  }

  /// Retrieves all the chats and updates the screen accordingly
  void updateChats() async {
    userChats.assignAll(await ChatRepository().fetchUserChats(user.id));
    await ShelterManager().retrieveShelters();
    update();
  }

  /// Navigates to the individual chat screen.
  ///
  /// The [chatIndex] parameter is the index of the chat to navigate to.
  ///
  /// This method sets the current shelter and dog based on the chat at the given
  /// [chatIndex] using the [ShelterManager] and [DogManager] classes.
  /// Finally, it navigates to the individual chat screen using the [Get.offNamed]
  /// method with the [Routes.INDIVIDUAL_CHAT] route.
  void navigateToSingleChat(int chatIndex) {
    ShelterManager().setCurrentShelterByID(userChats[chatIndex].shelterID);
    DogManager().setCurrentDogByID(userChats[chatIndex].dogID);
    Get.offNamed(Routes.INDIVIDUAL_CHAT);
  }

  /// Builds a separator widget for the chats list.
  ///
  /// The [index] parameter is the index of the chat to build the separator for.
  ///
  /// This method returns a [Container] widget with a height of 0.15 and a color
  /// of [ColorConstants.appGrey] if the chat at the given [index] is not the last chat in the list.
  /// Otherwise, it returns an empty [Container] widget.
  Widget chatSeparator(int index) {
    return (index + 1) < userChats.length
        ? Container(
            height: 0.15,
            color: ColorConstants.appGrey,
          )
        : Container();
  }

  /// Gets the picture URL of the dog in a chat.
  ///
  /// The [chat] parameter is the chat to get the dog picture URL for.
  ///
  /// This method returns the picture URL of the dog in the given [chat] using the [DogManager] class.
  String chatPictureURL(Chat chat) {
    return DogManager().getDogPictureURL(chat.dogID);
  }

  /// Gets the name of the dog in a chat.
  ///
  /// The [chat] parameter is the chat to get the dog name for.
  ///
  /// This method returns the name of the dog in the given [chat] using the [DogManager] class.
  String chatName(Chat chat) {
    return DogManager().getDogNameById(chat.dogID);
  }

  /// Gets the last message in a chat.
  ///
  /// The [chat] parameter is the chat to get the last message for.
  ///
  /// This method returns the text of the last message in the given [chat] if the chat has messages.
  /// Otherwise, it returns an empty string.
  String lastMsg(Chat chat) {
    return chat.messages.isNotEmpty
        ? chat.messages[chat.messages.length - 1].text
        : "";
  }

  /// Formats a message date.
  ///
  /// The [date] parameter is the date to format.
  ///
  /// This method returns a formatted string representing the given [date].
  /// If the date is today, it returns the formatted hour.
  /// If the date is yesterday, it returns the string "Ayer".
  /// Otherwise, it returns the formatted date.
  String msgDate(String date) {
    if (date.isEmpty) return "";
    DateTime dateTime = DateTime.parse(date);
    // Get the current date and time
    if (DateFormatter().isToday(dateTime)) {
      return DateFormatter().formatHour(dateTime);
    } else if (DateFormatter().isYesterday(dateTime)) {
      return StringConstants.yesterdayLabel;
    } else {
      return DateFormatter().formatDate(dateTime);
    }
  }
}
