import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/individual_chat/individual_chat_controller.dart';

import '../../shared/constants/colors.dart';
import '../../shared/widgets/chat_body.dart';

class IndividualChatScreen extends GetView<IndividualChatController> {
  const IndividualChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: controller.navigateToChats,
                    color: ColorConstants.appColor,
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        controller.currentDog().mainPictureURL,
                        width: 48,
                        height: 48,
                          fit: BoxFit.cover
                      ),
                    ),
                    onTap: controller.getToDogInfo,
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: controller.getToDogInfo,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.currentDog().name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 4),
                        Text(
                          controller.currentShelter().name, // TODO: Change the text for the shelter name
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: GestureDetector(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              controller.currentShelter().pictureURL),
                          radius: 20,
                        ),
                        onTap: controller.navigateToShelter,
                      ))
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              controller: controller.scrollController,
              itemCount: 20,
              itemBuilder: (context, index) {
                // received message
                return ChatBody(
                  isOwnMessage: index % 2 == 0,
                  hour: '10:00 AM',
                  text: 'Lorem ipsum lorem ipsum',
                );
              },
            )),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: ColorConstants.appColor,
                      decoration: InputDecoration(
                        hintText: 'Write a message...',
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
                      // handle button press
                    },
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.appColor,
                        ),
                        child: Align(
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
      ),
    ));
  }
}
