import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/shelter_profile/shelter_profile.dart';
import 'package:like_button/like_button.dart';

import '../../shared/constants/colors.dart';
import '../../shared/constants/styles.dart';
import '../../shared/widgets/horizontal_bar.dart';

class ShelterProfileScreen extends GetView<ShelterProfileController> {
  const ShelterProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: ColorConstants.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: ColorConstants.appColor,
                    onPressed: controller.navigateBack,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(controller.currentShelter().name,
                            style: Styles.shelterHeadline),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => LikeButton(
                            onTap: (bool isLiked) {
                              controller.toggleShelterLikeStatus(
                                  controller.currentShelter());
                              return Future.value(!isLiked);
                            },
                            isLiked: controller.isShelterLiked(
                                controller.currentShelter().id)),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(controller.currentShelter().pictureURL),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: controller.switchTab,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/dog.png", height: 35),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Perros en Adopción",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: controller.switchTab,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 10, 0),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.info,
                          size: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Información",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
              child: Obx(
                () => HorizontalBar(isLeft: controller.isBarLeft.value),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            Obx(() =>
                controller.getBodyContent(MediaQuery.of(context).size.width))
          ],
        ),
      ),
    ));
  }
}
