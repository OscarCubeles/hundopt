import 'package:get/get.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var currentTab = MainTabs.explore.obs;

  late ExploreTab exploreTab;
  late ChatTab chatTab;
  late FavouriteTab favouriteTab;
  late ProfileTab profileTab;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    exploreTab = ExploreTab();
    chatTab = ChatTab();
    favouriteTab = FavouriteTab();
    profileTab = ProfileTab();

  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) { // TODO: Canviar aquesta cutrada per un hashmap
    switch (tab) {
      case MainTabs.explore:
        return 0;
      case MainTabs.chat:
        return 1;
      case MainTabs.favourite:
        return 2;
      case MainTabs.profile:
        return 3;
      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) { // TODO: Canviar aquesta cutrada
    switch (index) {
      case 0:
        return MainTabs.explore;
      case 1:
        return MainTabs.chat;
      case 2:
        return MainTabs.favourite;
      case 3:
        return MainTabs.profile;
      default:
        return MainTabs.explore;
    }
  }

  increment() => count.value++;
}
