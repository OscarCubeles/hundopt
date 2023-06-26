import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/api/firebase_core/firebase_core.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

/// The [HomeController] class manages all the behaviour of the tab screens in the Hündopt app.
class HomeController extends GetxController {
  /// An integer representing the new tab.
  int newTab = Get.arguments;

  /// A tab controller for the Home screen.
  late PersistentTabController persistentTabController;

  /// An observable integer representing the count.
  final count = 0.obs;

  /// An observable representing the current tab.
  var currentTab = MainTabs.explore.obs;

  /// An instance of the ExploreTab class.
  late ExploreTab exploreTab;

  /// An instance of the ChatTab class.
  late ChatTab chatTab;

  /// An instance of the FavouriteTab class.
  late FavouriteTab favouriteTab;

  /// An instance of the ProfileTab class.
  late ProfileTab profileTab;

  /// A map of the content.
  dynamic contentMap;

  /// A map of the tabs.
  final tabMap = {
    0: MainTabs.explore,
    1: MainTabs.chat,
    2: MainTabs.favourite,
    3: MainTabs.profile,
  };

  /// Initiates the tabs to their corresponding screens,
  /// creates the tab controller with an initial index and gathers all dog and shelter data from DB
  @override
  void onInit() async {
    super.onInit();
    initTabs();
    persistentTabController =
        PersistentTabController(initialIndex: Get.arguments);
    currentTab.value = tabMap[newTab]!;
    await ShelterRepository().retrieveShelters(); // Retrieving all the shelters
    await DogRepository().retrieveDogs();
  }

  /// Sets the current tab to the tab passed as argument
  @override
  void onReady() {
    super.onReady();
    currentTab.value = tabMap[newTab]!;
  }

  /// Sets the initial tab as the explore
  @override
  void onClose() {
    currentTab.value = MainTabs.explore;
  }

  /// Initializes the tabs with their corresponding screen class and the initial tab screen
  void initTabs() {
    currentTab.value = MainTabs.explore;
    exploreTab = const ExploreTab();
    chatTab = const ChatTab();
    favouriteTab = const FavouriteTab();
    profileTab = const ProfileTab();
    contentMap = {
      MainTabs.explore: exploreTab,
      MainTabs.chat: chatTab,
      MainTabs.favourite: favouriteTab,
      MainTabs.profile: profileTab,
    };
  }

  /// Switches the tab.
  ///
  /// The [index] parameter is the index of the tab to switch to.
  /// It gets the current tab and updates the favorite and profile controllers.
  void switchTab(index) {
    var tab = _getCurrentTab(index);
    final FavouriteController favouriteController =
        Get.find<FavouriteController>();
    favouriteController.updateValues();
    final ProfileController profileController = Get.find<ProfileController>();
    profileController.setScreenValues();
    currentTab.value = tab!;
  }

  /// Gets the current tab.
  ///
  /// The [index] parameter is the index of the tab.
  /// It returns the current tab if it exists, otherwise it returns the explore tab.
  MainTabs? _getCurrentTab(int index) {
    return tabMap.containsKey(index) ? tabMap[index] : MainTabs.explore;
  }

  /// Builds the content.
  ///
  /// It returns the content of the current tab or the explore tab if the current tab doesn't exist.
  Widget buildContent() {
    return contentMap[currentTab.value] ?? exploreTab;
  }
}
