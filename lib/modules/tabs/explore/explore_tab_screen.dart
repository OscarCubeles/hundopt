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
import '../../../shared/widgets/app_page.dart';
import '../../../shared/widgets/video_player_item.dart';
import '../../home/home_controller.dart';

class ExploreTab extends GetView<ExploreController> {
  const ExploreTab({super.key});

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: PageController(),
          itemCount: 3,
          onPageChanged: (index) => controller.onPageChanged(index),
          itemBuilder: (context, index) {


            return GestureDetector(
              onTap: () {
                if (controller.videoController.value.isPlaying) {
                  controller.videoController.pause();
                  print("object");
                } else {
                  controller.videoController.play();
                  print("s");
                }
              },
              child: VideoPlayer(controller.videoController),

            );
          },
        ),
      ),
    );
  }*/

  // Aquest funciona correctament l'unic que li falla es que es per imatges i no per videos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: PageView.builder(
          controller: PageController(),
          scrollDirection: Axis.vertical,
          itemCount: controller.dogList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/example_dog.jpg"),
                ),
              ),
              child: GestureDetector(
                onTap: () => print("hola"),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
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
                                  padding: const EdgeInsets.fromLTRB(0,0,0,20.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Kira"),
                                          Text("Carrer Urgell 201"),
                                        ],
                                      ),
                                      Spacer(),
                                      Obx(
                                            () => LikeButton(
                                            size: 50,
                                            isLiked: controller.isLiked.value),
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
        ),
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
