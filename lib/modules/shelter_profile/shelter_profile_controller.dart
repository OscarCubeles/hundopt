import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../api/firebase_core/firebase_core.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';
import '../../shared/shared.dart';

/// The [ShelterProfileController] class manages all actions and data for the Shelter Profile view.
class ShelterProfileController extends GetxController {
  /// List of social media links.
  List<String> socialMediaList = [];

  /// The current user.
  late Rx<HundoptUser> user = HundoptUser.empty().obs;

  /// Whether the left or right tab is selected.
  RxBool isBarLeft = true.obs;

  /// List of dogs in the shelter.
  RxList shelterDogs = [].obs;

  /// Gathers all the user, dogs and shelter data to display it in screen.
  @override
  void onInit() async {
    super.onInit();
    isBarLeft.value = true;
    user.value = (await Auth().retrieveUser())!;
    await DogManager().retrieveDogs();
    await ShelterManager().retrieveShelters();
    shelterDogs
        .assignAll(await DogRepository().fetchShelterDogs(currentShelter().id));
    update();
  }

  /// Returns the current dog stored in the DogManager.
  Dog currentDog() {
    return DogManager().currentDog();
  }

  /// Returns the current shelter stored in the ShelterManager.
  Shelter currentShelter() {
    return ShelterManager().currentShelter();
  }

  /// Navigates back to the previous screen.
  void navigateBack() {
    Get.back();
  }

  /// Switches between the left and right tabs.
  void switchTab() {
    isBarLeft.value = !isBarLeft.value;
  }

  /// Toggles the like status of a shelter.
  ///
  /// The [shelter] parameter is the shelter to toggle the like status.
  /// If the shelter is already liked, it calls the `dislikeShelter` method.
  /// Otherwise, it calls the `likeShelter` method.
  void toggleShelterLikeStatus(Shelter shelter) {
    if (isShelterLiked(shelter.id)) {
      dislikeShelter(shelter);
      return;
    }
    likeShelter(shelter);
  }

  /// Removes a shelter from the user's favorite shelters list.
  ///
  /// The [shelter] parameter is the shelter to remove from the user's favorite shelters list.
  /// It removes the shelter from the database using the `UserRepository` class and removes it from the `favShelters` list of the user.

  void dislikeShelter(Shelter shelter) async {
    await UserRepository().removeFavShelter(user.value.id, shelter.id);
    user.value.favShelters.remove(shelter.id);
  }

  /// Adds a shelter to the user's favorite shelters list.
  ///
  /// The [shelter] parameter is the shelter to add to the user's favorite shelters list.
  /// It adds the shelter to the database using the `UserRepository` class and adds it to the `favShelters` list of the user.

  void likeShelter(Shelter shelter) async {
    await UserRepository().addFavShelter(user.value.id, shelter.id);
    user.value.favShelters.add(shelter.id);
  }

  /// Checks if a shelter is liked by the user.
  ///
  /// The [shelterID] parameter is the id of the shelter to check if it is liked by the user.
  /// It returns true if the shelter is in the `favShelters` list of the user, otherwise, it returns false.

  bool isShelterLiked(String shelterID) {
    for (int i = 0; i < user.value.favShelters.length; i++) {
      if (shelterID == user.value.favShelters[i]) {
        return true;
      }
    }
    return false;
  }

  /// Navigates to the Dog Info screen setting the current dog and current shelter in the data managers

  void navigateToDogInfo(Dog dog) {
    DogManager().setCurrentDog(dog);
    Get.offNamed(Routes.DOG_INFO);
  }

  /// Returns a  Widget with a grid of dogs of the current shelter or the shelter
  /// contact information depending on the current tab
  Widget getBodyContent(double screenWidth) {
    update();
    return isBarLeft.value ? dogGrid(screenWidth) : shelterInfo();
  }

  /// Returns an expanded widget containing a GridView with all the dogs of a shelter
  Widget dogGrid(double screenWidth) {
    return Expanded(
      child: SingleChildScrollView(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
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
                    margin: const EdgeInsets.all(10),
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
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            shelterDogs[index].name,
                            style: Styles.headlineMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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

  /// Returns an Expanded widget with a ListView containing all the data of a shelter
  Widget shelterInfo() {
    return Expanded(
        child: ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      children: [
        Text(StringConstants.locationLabel, style: Styles.headlineMedium),
        Text(
          currentShelter().location,
          style: Styles.bodySmall,
        ),
        const Padding(padding: EdgeInsets.all(10)),
        Text(StringConstants.phoneLabel, style: Styles.headlineMedium),
        Text(
          currentShelter().phone,
          style: Styles.bodySmall,
        ),
        const Padding(padding: EdgeInsets.all(10)),
        Text(StringConstants.fullEmailLabel, style: Styles.headlineMedium),
        Text(
          currentShelter().email,
          style: Styles.bodySmall,
        ),
        const Padding(padding: EdgeInsets.all(10)),
        Text(StringConstants.socialNetworksLabel, style: Styles.headlineMedium),
        const Padding(padding: EdgeInsets.all(5)),
        socialNetworksListView()
      ],
    ));
  }

  /// Returns a ListView with all the social networks of the shelter or an empty
  /// container depending if the shelter has social networks or not
  Widget socialNetworksListView() {
    return currentShelter().hasSocialNetworks()
        ? SizedBox(
            height: 500,
            child: ListView(
              children: [
                if (currentShelter().facebook.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue[900],
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Text(
                          currentShelter().facebook,
                          style: Styles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                if (currentShelter().twitter.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.blue,
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Text(
                          currentShelter().twitter,
                          style: Styles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                if (currentShelter().linkedin.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.linkedin,
                          color: Colors.blue[900],
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Text(
                          currentShelter().linkedin,
                          style: Styles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                if (currentShelter().tiktok.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          FontAwesomeIcons.tiktok,
                          color: Colors.black,
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
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
