import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/shelter_profile/shelter_profile.dart';
import 'package:like_button/like_button.dart';
import '../../shared/shared.dart';

/// The [ShelterProfileScreen] class representing the screen showing all the information
/// of a shelter, including their contact information, picture and dogs
class ShelterProfileScreen extends GetView<ShelterProfileController> {
  /// Constructs a new instance of the [ShelterProfileScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const ShelterProfileScreen({super.key});

  /// Builds the widget tree for the personality form questions screen.
  ///
  /// This method returns a [Scaffold] widget containing a [SafeArea] widget
  /// with a [Column] that has the general information of the shelter such as the name,
  /// profile picture and [getBodyContent] which returns either the Gird with all
  /// the shelter dogs or the column with all the information of the shelter
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
                        Image.asset(AssetsPath.defaultDogPic, height: 35),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            StringConstants.adoptingDogsLabel,
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
                            StringConstants.infoLabel,
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
