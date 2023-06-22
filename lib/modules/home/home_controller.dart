import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/firebase_core.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeController extends GetxController {
  int newTab = Get.arguments;
  late PersistentTabController persistentTabController;

  final count = 0.obs;
  var currentTab = MainTabs.explore.obs;
  late ExploreTab exploreTab;
  late ChatTab chatTab;
  late FavouriteTab favouriteTab;
  late ProfileTab profileTab;
  dynamic contentMap;
  final tabMap = {
    0: MainTabs.explore,
    1: MainTabs.chat,
    2: MainTabs.favourite,
    3: MainTabs.profile,
  };

  @override
  void onInit() async {
    super.onInit();
    initData();
    initTabs();
    persistentTabController =
        PersistentTabController(initialIndex: Get.arguments);
    currentTab.value = tabMap[newTab]!;
    await ShelterRepository().retrieveShelters(); // Retrieving all the shelters
    await DogRepository().retrieveDogs();
    print("object");
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen
    super.onReady();
    currentTab.value = tabMap[newTab]!;
    print(currentTab.value);
  }

  @override
  void onClose() {
    currentTab.value = MainTabs.explore;
  }

  void initTabs() {
    currentTab.value = MainTabs.explore;
    exploreTab = ExploreTab();
    chatTab = ChatTab();
    favouriteTab = FavouriteTab();
    profileTab = ProfileTab();
    contentMap = {
      MainTabs.explore: exploreTab,
      MainTabs.chat: chatTab,
      MainTabs.favourite: favouriteTab,
      MainTabs.profile: profileTab,
    };
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    final FavouriteController favouriteController =
        Get.find<FavouriteController>();
    favouriteController.updateValues();
    final ProfileController profileController = Get.find<ProfileController>();
    profileController.updateValues();
    currentTab.value = tab!;
  }

  MainTabs? _getCurrentTab(int index) {
    return tabMap.containsKey(index) ? tabMap[index] : MainTabs.explore;
  }

  Widget buildContent() {
    return contentMap[currentTab.value] ?? exploreTab;
  }

  void initData() {}
}
