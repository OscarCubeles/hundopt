import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:hundopt/shared/shared.dart';

/// The [ChatTab] class representing the screen with the list of chats for a given user
///
/// This class displays all the chats with their last message, last message date,
/// and the dog that the user wants to adopt
class ChatTab extends GetView<ChatController> {
  /// Constructs a new instance of the [ChatTab] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const ChatTab({super.key});

  /// Builds the widget tree for the chat screen.
  ///
  /// This method returns an [ChatTab] widget containing a [SingleChildScrollView] widget
  /// with a [ListView] containing all the chats for a given user
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(StringConstants.chatLabel,
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            Obx(() => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.userChats.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                        GestureDetector(
                          onTap: () {
                            controller.navigateToSingleChat(index);
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  controller.chatPictureURL(
                                      controller.userChats[index]),
                                  width: 84.0,
                                  height: 84.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                height: 60,
                                color: ColorConstants.background,
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        controller.chatName(
                                            controller.userChats[index]),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        controller.lastMsg(
                                            controller.userChats[index]),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  color: ColorConstants.background,
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              controller.msgDate(controller
                                                  .userChats[index]
                                                  .lastMessageDate),
                                              style: Styles.chatTabText,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                            ], //                                        Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                        controller.chatSeparator(index)
                      ],
                    );
                  },
                ))
          ],
        )));
  }
}
