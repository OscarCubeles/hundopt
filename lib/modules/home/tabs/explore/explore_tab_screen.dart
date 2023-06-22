import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:like_button/like_button.dart';
import '../../../../shared/shared.dart';

class ExploreTab extends GetView<ExploreController> {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Obx(() => PageView.builder(
              controller: PageController(initialPage: controller.initialPage()),
              // TODO: Create custom page controller to set the initial one to a custom one
              scrollDirection: Axis.vertical,
              itemCount: controller.dogList.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          controller.dogList[index].mainPictureURL),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => controller.navigateToDogInfo(controller.dogList[index]),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 10, 20),
                                            child: Obx(
                                              () =>  LikeButton(
                                                onTap: (bool isLiked) {
                                                  controller.toggleLikeStatus(controller
                                                      .dogList[index].id);
                                                  return Future.value(!isLiked);
                                                },
                                                    size: 50,
                                                    isLiked: controller
                                                        .isDogLiked(controller
                                                        .dogList[index].id)),

                                              )
                                            ),

                                          const SizedBox(width: 8),
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

}
