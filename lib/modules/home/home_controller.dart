import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var currentTab = MainTabs.explore.obs;

  final tabMap = {
    0: MainTabs.explore,
    1: MainTabs.chat,
    2: MainTabs.favourite,
    3: MainTabs.profile,
  };
  late ExploreTab exploreTab;
  late ChatTab chatTab;
  late FavouriteTab favouriteTab;
  late ProfileTab profileTab;

  dynamic contentMap;

  @override
  void onInit() {
    super.onInit();
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
    currentTab.value = tab!;
  }

  MainTabs? _getCurrentTab(int index) {
    return tabMap.containsKey(index) ? tabMap[index] : MainTabs.explore;
  }

  Widget buildContent() {
    return contentMap[currentTab.value] ?? exploreTab;
  }
}
