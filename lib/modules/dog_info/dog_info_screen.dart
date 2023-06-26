import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/dog_info/dog_info_controller.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:like_button/like_button.dart';

/// The [DogInfoScreen] class representing the screen with all the dog information
/// of the Hundopt app.
///
/// This class displays all the dog information such as pictures, name, description,
/// health status, behaviour status, shelter, location, etc...
class DogInfoScreen extends GetView<DogInfoController> {
  /// Constructs a new instance of the [DogInfoScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const DogInfoScreen({super.key});

  /// Builds the widget tree for the register screen.
  ///
  /// This method returns an [Scaffold] widget containing a [Column] widget
  /// with a [Stack]  with the dog pictures and a [Padding] with children widgets
  /// to show in screen all the dog informaiton
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView.builder(
                  itemCount: controller.currentDog().pictureURLs.length,
                  onPageChanged: controller.updateIndex,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                controller.currentDog().pictureURLs[index],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //Optional container to add color  gradeint on the top of the image
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(.05),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                top: 40.0,
                left: 10.0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: ColorConstants.background,
                  onPressed: controller.navigateToExplore,
                ),
              ),
              Positioned(
                top: 40.0,
                right: 10.0,
                child: IconButton(
                  color: controller.currentDog().isReserved
                      ? ColorConstants.background
                      : ColorConstants.invisible,
                  icon: const Icon(Icons.bookmark),
                  onPressed: () {},
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller
                          .currentDog()
                          .pictureURLs
                          .asMap()
                          .entries
                          .map((entry) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.imageIndex.value == entry.key
                                ? Colors.white
                                : Colors.grey,
                          ),
                        );
                      }).toList(),
                    )),
              ),
            ]),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.currentDog().name,
                          style: textTheme.headlineSmall),
                      Obx(
                        () => LikeButton(
                            onTap: (bool isLiked) {
                              controller
                                  .toggleLikeStatus(controller.currentDog().id);
                              return Future.value(!isLiked);
                            },
                            size: 40,
                            isLiked: controller
                                .isDogLiked(controller.currentDog().id)),
                      ),
                    ],
                  ),
                  Text(controller.currentDog().breed,
                      style: textTheme.bodyMedium),
                  const SizedBox(height: 16.0),
                  Text(StringConstants.descriptionLabel,
                      style: textTheme.headlineMedium),
                  const SizedBox(height: 8.0),
                  Text(
                    controller.currentDog().description,
                    style: Styles.bodyDescription,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    StringConstants.dogDescriptionLabel,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GridTextTile(
                              title: StringConstants.ageLabel,
                              text: controller.currentDog().age.toString(),
                              width: width),
                          GridTextTile(
                              title: StringConstants.sizeLabel,
                              text: controller.currentDog().size,
                              width: width),
                          GridGenderTile(
                            gender: StringConstants.genderLabel,
                            width: width,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Text(
                    StringConstants.friendlyLabel,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  FeatureList(
                    width: MediaQuery.of(context).size.width,
                    positiveFeatures: controller.currentDog().friendly,
                    negativeFeatures: controller.currentDog().notFriendly,
                  ),
                  Text(
                    StringConstants.healthLabel,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  FeatureList(
                    width: MediaQuery.of(context).size.width,
                    positiveFeatures: controller.currentDog().healthPositive,
                    negativeFeatures: controller.currentDog().healthNegative,
                  ),
                  Text(
                    StringConstants.personalityLabel,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  FeatureList(
                    width: MediaQuery.of(context).size.width,
                    positiveFeatures: controller.currentDog().personality,
                    negativeFeatures: const [],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringConstants.dogLocationLabel,
                        style: textTheme.headlineMedium,
                      ),
                      Row(
                        children: [
                          Text(
                            controller.currentDog().location,
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    onTap: controller.navigateToShelterScreen,
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstants.singleCentreLabel,
                            style: textTheme.headlineMedium,
                            textAlign: TextAlign.justify,
                          ),
                          Text(controller.currentShelter().name,
                              style: textTheme.bodyMedium),
                        ]),
                    subtitle: Row(
                      children: [
                        Text(
                          controller.currentShelter().location,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: CircleAvatar(
                      backgroundImage:
                          NetworkImage(controller.currentShelter().pictureURL),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: AppPrimaryButton(
                          text: StringConstants.startAdoptLabel,
                          onPressed: controller.showConfirmAdoptDialog))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
