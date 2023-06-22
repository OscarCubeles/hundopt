import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../api/firebase_core/firebase_core.dart';
import '../../models/model.dart';
import '../../routes/app_pages.dart';
import '../../shared/shared.dart';

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
    await DogManager().retrieveDogs();
    await ShelterManager().retrieveShelters();

    shelterDogs
        .assignAll(await DogRepository().fetchShelterDogs(currentShelter().id));
    update();
  }

  Dog currentDog() {
    return DogManager().currentDog();
  }

  Shelter currentShelter() {
    return ShelterManager().currentShelter();
  }

  void navigateBack() {
    Get.back();
  }

  void switchTab() {
    isBarLeft.value = !isBarLeft.value;
  }

  void toggleShelterLikeStatus(Shelter shelter) {
    if (isShelterLiked(shelter.id)) {
      dislikeShelter(shelter);
      return;
    }
    likeShelter(shelter);
  }
  void dislikeShelter(Shelter shelter) async {
    await UserRepository().removeFavShelter(user.value.id, shelter.id);
    user.value.favShelters.remove(shelter.id);
  }

  void likeShelter(Shelter shelter) async {
    await UserRepository().addFavShelter(user.value.id, shelter.id);
    user.value.favShelters.add(shelter.id);
  }

  bool isShelterLiked(String shelterID) {
    for (int i = 0; i < user.value.favShelters.length; i++) {
      if (shelterID == user.value.favShelters[i]) {
        return true;
      }
    }
    return false;
  }

  void navigateToDogInfo(Dog dog) {
    DogManager().setCurrentDog(dog);
    Get.offNamed(Routes.DOG_INFO);
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

  // TODO CHange this strings to constants and put this widget as a widget constant
  Widget shelterInfo() {
    return Expanded(
        child: ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      children: [
        Text("Ubicación", style: Styles.headlineMedium),
        Text(
          currentShelter().location,
          style: Styles.bodySmall,
        ),
        const Padding(padding: EdgeInsets.all(10)),
        Text("Teléfono", style: Styles.headlineMedium),
        Text(
          currentShelter().phone,
          style: Styles.bodySmall,
        ),
        const Padding(padding: EdgeInsets.all(10)),
        Text("Correo Electrónico", style: Styles.headlineMedium),
        Text(
          currentShelter().email,
          style: Styles.bodySmall,
        ),
        const Padding(padding: EdgeInsets.all(10)),
        Text("Redes Sociales", style: Styles.headlineMedium),
        const Padding(padding: EdgeInsets.all(5)),
        socialNetworksListView()
      ],
    ));
  }

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
