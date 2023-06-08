import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../api/firebase_core/dog_repository.dart';
import '../../api/firebase_core/shelter_repository.dart';
import '../../models/dog.dart';
import '../../models/shelter.dart';
import '../../shared/constants/styles.dart';
import '../../shared/services/dog_singleton.dart';
import '../../shared/services/shelter_singleton.dart';

class ShelterProfileController extends GetxController {
  List<String> socialMediaList = [];
  RxBool isBarLeft = true.obs;
  RxList shelterDogs = [].obs;


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
  void onInit() async {
    super.onInit();
    isBarLeft.value = true;
    //socialMediaList = socialMediaMap.keys.toList();
    // TODO: Put this as a service bc its kinda ugly to have it everywhere
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
    if (ShelterSingleton().shelters == []) {
      await ShelterRepository().retrieveShelters();
    }
    shelterDogs.assignAll(await DogRepository().fetchDogsByShelterID(currentShelter().id));

    // Trigger view update
    update();
  }

  Dog currentDog() {
    return DogSingleton().dogs![DogSingleton().dogIndex!]; // TODO: Put this as a service
  }

  Shelter currentShelter(){
    return ShelterSingleton().shelters[ShelterSingleton().shelterIndex]; // TODO: Put this as a service
  }

  void navigateBack() {
    Get.back();
  }

  void switchTab() {
    isBarLeft.value = !isBarLeft.value;
  }

  // TODO: Put this widget as widget constant
  Widget getDogGrid(double screenWidth) {
    return Expanded(
      child: SingleChildScrollView(
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: List.generate(shelterDogs.length, (index) {
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
                              aspectRatio: 1 / 1,
                              child: Image.network(
                                shelterDogs[index].mainPictureURL,
                                fit: BoxFit.cover,
                                width: 84.0,
                                height: 84.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          shelterDogs[index].name,
                          style: Styles.headlineMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          shelterDogs[index].breed,
                          style: Styles.bodySmall,
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
    update();
    return isBarLeft.value ? getDogGrid(screenWidth) : getShelterBody();
  }

  // TODO CHange this strings to constants and put this widget as a widget constant
  Widget getShelterBody() {
    return Expanded(
        child: ListView(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      children: [
        Text("Ubicación", style: Styles.headlineMedium),
        Text(
          currentShelter().location,
          style: Styles.bodySmall,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text("Teléfono", style: Styles.headlineMedium),
        Text(
          currentShelter().phone,
          style: Styles.bodySmall,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text("Correo Electrónico", style: Styles.headlineMedium),
        Text(
          currentShelter().email,
          style: Styles.bodySmall,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text("Redes Sociales", style: Styles.headlineMedium),
        // TODO: Add an if statement to check if it has RRSS
        Padding(padding: EdgeInsets.all(5)),

        getSocialNetworks() // TODO : Change this if it does not have social media
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
