import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/tabs/explore/explore_tab_controller.dart';
import 'package:like_button/like_button.dart';
import 'package:video_player/video_player.dart';

import '../../../../shared/constants/colors.dart';
import '../../../../shared/widgets/app_bar.dart';
import '../../../shared/constants/string_constants.dart';
import '../../../shared/constants/styles.dart';
import '../../../shared/widgets/app_page.dart';
import '../../../shared/widgets/video_player_item.dart';
import '../../home/home_controller.dart';

class ExploreTab extends GetView<ExploreController> {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Obx(() => PageView.builder(
              controller: PageController(), // TODO: Create custom page controller to set the initial one to a custom one
              scrollDirection: Axis.vertical,
              itemCount: controller.dogList.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(controller.dogList[index].mainPictureURL),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => controller.navigateToDogInfo(index),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(1),
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () => print("tapped colunm"),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 20.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  controller
                                                      .dogList[index].name,
                                                  style: Styles.nameLabelWhite),
                                              Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .location_solid,
                                                    color: ColorConstants
                                                        .background,
                                                  ),
                                                  Text(
                                                    controller.dogList[index]
                                                        .location,
                                                    style: Styles
                                                        .locationLabelWhite,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 10, 20),
                                            child: Obx(
                                              () => LikeButton(
                                                  size: 50,
                                                  isLiked:
                                                      controller.isLiked.value),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        /*Positioned.fill(
                      child: InkWell(
                        onTap: () => print("tapped"),
                        onDoubleTap: controller.likeDog,
                      ),
                    ),*/
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: PageController(),
        children: [
          Scaffold(
            backgroundColor: Colors.red,
          ),
          Scaffold(
            backgroundColor: Colors.blue,
          ),
          Scaffold(
            backgroundColor: Colors.green,
          )

        ],
      ),
    );
  }*/
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Obx(() {
          return PageView.builder(
            itemCount: controller.dogList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              final data = controller.dogList[index];
              return Stack(
                children: [
                VideoPlayerItem(
                videoUrl: data.videoUrl,
              ),
              ]);

            },
          );
        }));
  }*/
}
