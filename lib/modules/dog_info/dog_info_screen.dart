import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/dog_info/dog_info_controller.dart';
import 'package:hundopt/shared/constants/constants.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:like_button/like_button.dart';

import '../../shared/widgets/feature_list.dart';

class DogInfoScreen extends GetView<DogInfoController> {
  DogInfoScreen({super.key});

  final List<String> images = [
    "assets/images/kira-dog.JPG",
    "assets/images/kira-dog2.JPG",
    "assets/images/kira-dog3.JPG",
  ];

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
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView.builder(
                  itemCount: images.length,
                  onPageChanged: controller.updateIndex,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                images[index],
                              ),
                            ),
                          ),
                        ),
                        /*Container( TODO: Optional container to add color  gradeint on the top of the image
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(.5),
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      )*/
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
                  color: ColorConstants.background,
                  icon: Icon(Icons.bookmark),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: images.asMap().entries.map((entry) {
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
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kira", style: textTheme.headlineSmall),
                      LikeButton(
                        size: 40,
                      ),
                    ],
                  ),
                  Text("Labrador", style: textTheme.bodyMedium),
                  SizedBox(height: 16.0),
                  Text("Descripción", style: textTheme.headlineMedium),
                  SizedBox(height: 8.0),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sodales justo ac arcu hendrerit fringilla. Vivamus euismod rhoncus nisi sit amet eleifend. Proin non dapibus purus. Etiam et est sed libero lobortis bibendum. Duis eget felis odio. Mauris pretium elit vitae velit ultricies elementum. Aenean eu est a libero pharetra fringilla. Aliquam tempus iaculis tellus, in sodales neque malesuada sed.",
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
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildGridTile('Tile 1', Icons.star, width),
                          _buildGridTile('Tile 2', Icons.favorite, width),
                          _buildGridTile('Tile 3', Icons.camera_alt, width),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildGridTile('Tile 4', Icons.music_note, width),
                          _buildGridTile(
                              'Tile 5', Icons.directions_bike, width),
                          _buildGridTile('Tile 6', Icons.shopping_cart, width),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  Text(
                    "Amigabilidad",
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  FeatureList(
                    width: MediaQuery.of(context).size.width,
                    positiveFeatures: controller.positiveDogFeatures,
                    negativeFeatures: controller.positiveDogFeatures,
                  ),
                  Text(
                    "Estado de Salud",
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  FeatureList(
                    width: MediaQuery.of(context).size.width,
                    positiveFeatures: controller.positiveDogFeatures,
                    negativeFeatures: controller.positiveDogFeatures,
                  ),
                  Text(
                    "Personalidad",
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.justify,
                  ),
                  FeatureList(
                    width: MediaQuery.of(context).size.width,
                    positiveFeatures: controller.positiveDogFeatures,
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
                          /*Icon(
                            CupertinoIcons.location_solid,
                            color: Colors.black,
                          ),*/
                          Text(
                            "Barcelona",
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    onTap: () => print("Perrera pressed"),
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Centro",
                            style: textTheme.headlineMedium,
                            textAlign: TextAlign.justify,
                          ),
                          Text("Perrera la guarda",
                              style: textTheme.bodyMedium),
                        ]),
                    subtitle: Row(
                      children: [
                        /*Icon(
                          CupertinoIcons.location_solid,
                          color: Colors.black,
                        ),*/
                        Text(
                          "Barcelona",
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/kira-dog.JPG"),
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

  Widget _buildGridTile(String text, IconData icon, double width) {
    return Container(
      width: width / 3 - 20,
      height: 80,
      decoration: BoxDecoration(
        color: ColorConstants.transparentAppColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(
      IconData icon, String featureName, Color color, TextStyle style) {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Icon(icon, color: color)),
        Text(featureName, style: style),
      ],
    );
  }
}