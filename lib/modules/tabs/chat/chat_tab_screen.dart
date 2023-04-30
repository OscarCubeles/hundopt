import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/tabs/chat/chat_tab_controller.dart';
import 'package:hundopt/shared/shared.dart';

import '../../../routes/app_pages.dart';
import '../../home/home_controller.dart';

class ChatTab extends GetView<ChatController> {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: true,
      child: SingleChildScrollView(
        child: Column(
            children: [
            Text("Chat"),
        Obx(
              () =>
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),

                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.chatList.length,
                  itemBuilder: (context, index) {
        final chat = controller.chatList[index];
        return ListTile(
        title: Text(chat.lastMessage),
        subtitle: Text(chat.name),
        trailing: Text(chat.lastMessageReceivedTime.toString()),
        );
        },
        ),
      )
      ],
    )));
  }
}
