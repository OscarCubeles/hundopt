import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:hundopt/modules/tabs/chat/chat_tab_controller.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:intl/intl.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(StringConstants.chatLabel,
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            Obx(() => Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.chatList.length,
                    itemBuilder: (context, index) {
                      final chat = controller.chatList[index];
                      return Container(
                          child: Column(
                        children: [
                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                          GestureDetector(
                            onTap: () {
                              print("hola");
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    chat.pictureUrl,
                                    width: 84.0,
                                    height: 84.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                          chat.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          chat.lastMessage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          overflow: TextOverflow.ellipsis,
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
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: controller.getChatDate(
                                            chat.lastMessageReceivedTime,
                                            Theme.of(context)
                                                .textTheme
                                                .labelSmall!),
                                      ),
                                    ))
                              ], //                                        Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                          Container(
                            height: 0.5,
                            color: ColorConstants.appGrey,
                          )
                        ],
                      ));
                    },
                  ),
                ))
          ],
        )));
  }
}
