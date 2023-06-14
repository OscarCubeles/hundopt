import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../api/firebase_core/auth.dart';
import '../../api/firebase_core/dog_repository.dart';
import '../../api/firebase_core/shelter_repository.dart';
import '../../api/firebase_core/user_repository.dart';
import '../../models/dog.dart';
import '../../models/shelter.dart';
import '../../models/user.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/styles.dart';
import '../../shared/services/dog_singleton.dart';
import '../../shared/services/shelter_singleton.dart';

class ShelterProfileController extends GetxController {
  List<String> socialMediaList = [];
  late Rx<HundoptUser> user = HundoptUser.empty().obs;
  RxBool isBarLeft = true.obs;
  RxList shelterDogs = [].obs;

  @override
  void onInit() async {
    super.onInit();
    isBarLeft.value = true;

    user.value = (await Auth().retrieveUser())!;

    // TODO: Put this as a service bc its kinda ugly to have it everywhere
    if (DogSingleton().dogs == null) {
      await DogRepository().retrieveDogs();
    }
    if (ShelterSingleton().shelters == []) {
      await ShelterRepository().retrieveShelters();
    }

    shelterDogs
        .assignAll(await DogRepository().fetchShelterDogs(currentShelter().id));
    update();
  }

  Dog currentDog() {
    // TODO: Put this as a service
    return DogSingleton().dogs![DogSingleton().dogIndex!];
  }

  Shelter currentShelter() {
    // TODO: Put this as a service
    return ShelterSingleton().shelters[ShelterSingleton().shelterIndex];
  }

  void navigateBack() {
    Get.back();
  }

  void switchTab() {
    isBarLeft.value = !isBarLeft.value;
  }


  void onLikePressed() {
    //TODO: Set the shelter as liked
  }


  // TODO: Add this as a service
  void toggleShelterLikeStatus(Shelter shelter) {
    if (isShelterLiked(shelter.id)) {
      dislikeShelter(shelter);
      return;
    }
    likeShelter(shelter);
  }

  // TODO: Put this as a service
  void dislikeShelter(Shelter shelter) async {
    await UserRepository().removeFavShelter(user.value.id, shelter.id);
    user.value.favShelters.remove(shelter.id);
  }

  // TODO: Put this as a service
  void likeShelter(Shelter shelter) async {
    await UserRepository().addFavShelter(user.value.id, shelter.id);
    user.value.favShelters.add(shelter.id);
  }

  // TODO: Put this as a service
  bool isShelterLiked(String shelterID) {
    for (int i = 0; i < user.value.favShelters.length; i++) {
      if (shelterID == user.value.favShelters[i]) {
        return true;
      }
    }
    return false;
  }

  void navigateToDogInfo(Dog dog) {
    // TODO: Add this method in the service that uses the singleton, the service could be called dogmanager
    int i = 0;
    for (Dog tmpDog in DogSingleton().dogs!) {
      if (dog.id == tmpDog.id) {
        DogSingleton().dogIndex = i;
        Get.offNamed(Routes.DOG_INFO, arguments: tmpDog);
        break;
      }
      i++;
    }
  }


  Widget getBodyContent(double screenWidth) {
    update();
    return isBarLeft.value ? dogGrid(screenWidth) : shelterInfo();
  }


  // TODO: Put this widget as widget constant
  Widget dogGrid(double screenWidth) {
    return Expanded(
      child: SingleChildScrollView(
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: List.generate(shelterDogs.length, (index) {
            return GestureDetector(
              onTap: () => {
                navigateToDogInfo(shelterDogs[index]),
              },
              child: GridTile(
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
              ),
            );
          }),
        ),
      ),
    );
  }

  // TODO CHange this strings to constants and put this widget as a widget constant
  Widget shelterInfo() {
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
        Padding(padding: EdgeInsets.all(5)),
        socialNetworksListView()
      ],
    ));
  }

  Widget socialNetworksListView() {
    return currentShelter().hasSocialNetworks()
        ? Container(
            height: 500,
            child: ListView(
              children: [
                if (currentShelter().facebook.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue[900],
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          currentShelter().facebook,
                          style: Styles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                if (currentShelter().twitter.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.blue,
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          currentShelter().twitter,
                          style: Styles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                if (currentShelter().linkedin.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.linkedin,
                          color: Colors.blue[900],
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          currentShelter().linkedin,
                          style: Styles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                if (currentShelter().tiktok.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.tiktok,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          currentShelter().tiktok,
                          style: Styles.bodySmall,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        : Container();
  }




}
