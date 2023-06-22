import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../api/firebase_core/firebase_core.dart';
import '../../../../models/model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/shared.dart';

class ChatController extends GetxController {
  RxList userChats = [].obs;
  late HundoptUser user = HundoptUser.empty();

  @override
  void onInit() async {
    super.onInit();
    user = (await Auth().retrieveUser())!;
    userChats.assignAll(await ChatRepository().fetchUserChats(user.id));
    await ShelterManager().retrieveShelters();
    update();
  }


  void navigateToSingleChat(int chatIndex) {
    ShelterManager().setCurrentShelterByID(userChats[chatIndex].shelterID);
    DogManager().setCurrentDogByID(userChats[chatIndex].dogID);
    Get.offNamed(Routes.INDIVIDUAL_CHAT);
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
    return DogManager().getDogPictureURL(chat.dogID);
  }

  String chatName(Chat chat) {
    return DogManager().getDogNameById(chat.dogID);
  }

  String lastMsg(Chat chat) {
    return chat.messages.isNotEmpty
        ? chat.messages[chat.messages.length - 1].text
        : "";
  }

  String msgDate(String date) {
    if (date.isEmpty) return "";
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
