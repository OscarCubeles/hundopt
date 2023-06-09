import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/individual_chat/individual_chat_controller.dart';
import '../../shared/shared.dart';

/// The [IndividualChatScreen] class representing the screen with the list
/// of messages between a user and a shelter in a chat.
/// This class displays all the messages with their time, and has a [TextField]
/// to send new messages to the shelter
class IndividualChatScreen extends GetView<IndividualChatController> {
  /// Constructs a new instance of the [IndividualChatScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const IndividualChatScreen({super.key});

  /// Builds the widget tree for the individual chat screen.
  ///
  /// This method returns an [Scaffold] widget containing a [Column] widget
  /// with a  [Container] with the dog picture, name and shelter on top of the screen.
  /// Also with a [ListView] with a list of all the messages between the user and the shelter
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: controller.navigateToChats,
                  color: ColorConstants.appColor,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.getToDogInfo,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(controller.currentDog().mainPictureURL,
                        width: 48, height: 48, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: controller.getToDogInfo,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.currentDog().name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.currentShelter().name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: GestureDetector(
                      onTap: controller.navigateToShelter,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            controller.currentShelter().pictureURL),
                        radius: 20,
                      ),
                    ))
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.chat.value.messages.length,
                itemBuilder: (context, index) {
                  // received message
                  return ChatBody(
                    isOwnMessage: !controller.chat.value.messages[index].isUser,
                    hour: controller
                        .msgDate(controller.chat.value.messages[index].date),
                    text: controller.chat.value.messages[index].text,
                  );
                },
              ),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textEditingController,
                    onChanged: controller.messageChanged,
                    cursorColor: ColorConstants.appColor,
                    decoration: const InputDecoration(
                      hintText: StringConstants.chatWriteLabel,
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                    style: Theme.of(context).textTheme.labelMedium,
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.addChatMessage();
                  },
                  child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.appColor,
                      ),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 2, 0),
                            child: Icon(
                              CupertinoIcons.paperplane,
                              color: Colors.white,
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
