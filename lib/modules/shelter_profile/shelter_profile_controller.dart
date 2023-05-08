import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../models/shelter.dart';
import '../../shared/constants/styles.dart';

class ShelterProfileController extends GetxController {
  List<String> socialMediaList = [];
  RxBool isBarLeft = true.obs;
  Shelter shelter = Shelter(
      name: 'Perrera feliz',
      email: 'info@perrera.com',
      phone: '+34 665787221',
      location: "Barcelona Carrer Cases 21",
      hasSocialNetworks: true);

  Map<String, IconData> socialMediaMap = {
    'Twitter': FontAwesomeIcons.twitter,
    'Facebook': FontAwesomeIcons.facebook,
    'Instagram': FontAwesomeIcons.instagram,
    'TikTok': FontAwesomeIcons.tiktok,
  };

  final socialMediaColorMap = {
    'Twitter': Colors.blue,
    'Facebook': Colors.blue[900],
    'Instagram': Colors.pink,
    'TikTok': Colors.black,
  };

  @override
  void onInit() {
    isBarLeft.value = true;
    //socialMediaList = socialMediaMap.keys.toList();
  }

  void navigateBack() {
    Get.back();
  }

  void switchTab() {
    isBarLeft.value = !isBarLeft.value;
  }

  Widget getDogGrid(double screenWidth) {
    return Expanded(
      child: SingleChildScrollView(
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: List.generate(20, (index) {
            return GridTile(
              child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth, // set maximum
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SizedBox.fromSize(
                            child: AspectRatio(
                              child: Image.asset(
                                'assets/images/kira-dog.JPG',
                                fit: BoxFit.cover,
                                width: 84.0,
                                height: 84.0,
                              ),
                              aspectRatio: 1 / 1,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          "Kira",
                          style: Styles.headlineMedium,
                        ),
                      )
                    ],
                  )),
            );
          }),
        ),
      ),
    );
  }

  Widget getBodyContent(double screenWidth) {
    return isBarLeft.value ? getDogGrid(screenWidth) : getShelterBody();
  }

  // TODO CHange this strings to constants
  Widget getShelterBody() {
    return Expanded(
        child: ListView(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      children: [
        Text("Ubicación", style: Styles.headlineMedium),
        Text(
          shelter.location,
          style: Styles.bodySmall,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text("Teléfono", style: Styles.headlineMedium),
        Text(
          shelter.phone,
          style: Styles.bodySmall,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text("Correo Electrónico", style: Styles.headlineMedium),
        Text(
          shelter.email,
          style: Styles.bodySmall,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text("Redes Sociales", style: Styles.headlineMedium),
        // TODO: Add an if statement to check if it has RRSS
        Padding(padding: EdgeInsets.all(5)),

        //getSocialNetworks() // TODO : Change this if it does not have social media
      ],
    ));
  }

  Widget getSocialNetworks() {
    return Container(
      height: 500,
      child: ListView.builder(
        itemCount: socialMediaList.length,
        itemBuilder: (context, index) {
          String socialMediaName = socialMediaMap.keys.elementAt(index);
          return Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    socialMediaMap[socialMediaList[index]],
                    color: socialMediaColorMap[socialMediaName],
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    "@perreraFelix",
                    style: Styles.bodySmall,
                  ),
                ],
              ));
        },
      ),
    );
  }

  void onLikePressed() {}
}
