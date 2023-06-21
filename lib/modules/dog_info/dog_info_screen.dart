import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/dog_info/dog_info_controller.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:hundopt/shared/widgets/grid_gender_tile.dart';
import 'package:hundopt/shared/widgets/grid_text_tile.dart';
import 'package:like_button/like_button.dart';

import '../../shared/widgets/feature_list.dart';

class DogInfoScreen extends GetView<DogInfoController> {
  const DogInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
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
                  icon: Icon(Icons.arrow_back),
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
                  icon: Icon(Icons.bookmark),
                  onPressed: () {

                  },
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
                            () =>  LikeButton(
                            onTap: (bool isLiked) {
                              controller.toggleLikeStatus(controller
                                  .currentDog().id);
                              return Future.value(!isLiked);
                            },
                            size: 40,
                            isLiked: controller
                                .isDogLiked(controller
                                .currentDog().id)),

                      )
                      ,
                    ],
                  ),
                  Text(controller.currentDog().breed,
                      style: textTheme.bodyMedium),
                  const SizedBox(height: 16.0),
                  Text("Descripción", style: textTheme.headlineMedium),
                  const SizedBox(height: 8.0),
                  Text(
                    controller.currentDog().description,
                    style: Styles.bodyDescription,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Datos del perro",
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
                              title: 'Edad',
                              text: controller.currentDog().age.toString(),
                              width: width),
                          GridTextTile(
                              title: 'Tamaño',
                              text: controller.currentDog().size,
                              width: width),
                          GridGenderTile(
                            gender: 'Género',
                            width: width,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Text(
                    "Amigabilidad",
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  FeatureList(
                    width: MediaQuery.of(context).size.width,
                    positiveFeatures: controller.currentDog().friendly,
                    negativeFeatures: controller.currentDog().notFriendly,
                  ),
                  Text(
                    "Estado de Salud",
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  FeatureList(
                    width: MediaQuery.of(context).size.width,
                    positiveFeatures: controller.currentDog().healthPositive,
                    negativeFeatures: controller.currentDog().healthNegative,
                  ),
                  Text(
                    "Personalidad",
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  FeatureList(
                    width: MediaQuery.of(context).size.width,
                    positiveFeatures: controller.currentDog().personality,
                    negativeFeatures: [],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ubicación del perro",
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
                        contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        onTap: controller.navigateToShelterScreen,
                        title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Centro",
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
                          backgroundImage: NetworkImage(
                              controller.currentShelter().pictureURL),
                        ),
                      ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: AppPrimaryButton(
                          text: "¡Empezar Adopción!",
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
