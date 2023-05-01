import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Chat",
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
                          child:  Column(
                                children: [
                                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          chat.pictureUrl,
                                          width: 84.0,
                                          height: 84.0,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
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
