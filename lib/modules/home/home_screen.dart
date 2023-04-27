import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../shared/constants/colors.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Obx(() => _buildWidget(context)),
      ),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _buildContent(controller.currentTab.value),
        ),
        bottomNavigationBar: PersistentTabView(context,
            screens: _buildScreens(),
            confineInSafeArea: true,
            backgroundColor: ColorConstants.background,
            // Default is Colors.white.
            handleAndroidBackButtonPress: true,
            // Default is true.
            resizeToAvoidBottomInset: true,
            // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style12,
            items: [
              _buildNavigationBarItem("explore", CupertinoIcons.search,"icon_home.svg"),
              _buildNavigationBarItem("explore2", CupertinoIcons.chat_bubble_2,"icon_home.svg"),
              _buildNavigationBarItem("explore", CupertinoIcons.heart,"icon_home.svg"),
              _buildNavigationBarItem("explore", CupertinoIcons.person,"icon_home.svg")
            ]));
  }

  List<Widget> _buildScreens() {
    return const [ExploreTab(), ChatTab(), FavouriteTab(), ProfileTab()];
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.explore:
        return controller.exploreTab;
      case MainTabs.chat:
        return controller.chatTab;
      case MainTabs.favourite:
        return controller.favouriteTab;
      case MainTabs.profile:
        return controller.profileTab;
      default:
        return controller.exploreTab;
    }
  }

  PersistentBottomNavBarItem _buildNavigationBarItem(String label, IconData iconData, String svg) {
    return PersistentBottomNavBarItem(
      icon: Icon(iconData),
      title: label,
      activeColorPrimary: ColorConstants.appColor,
      inactiveColorPrimary: ColorConstants.appGrey,
    );
  }
}
