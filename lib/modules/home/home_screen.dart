import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../shared/constants/constants.dart';
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
          child: controller.buildContent(),
        ),
        // TODO: Addnavigationbar in widgets
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
            onItemSelected: (index) => controller.switchTab(index),
            items: [
              _buildNavigationBarItem(
                  "explore", const Icon(CupertinoIcons.home), true,
                  svgPath: AssetsPath.svgAppLogo, currentColor: currentColor()),
              _buildNavigationBarItem(
                  "explore2", const Icon(CupertinoIcons.chat_bubble_2), false),
              _buildNavigationBarItem(
                  "explore", const Icon(CupertinoIcons.heart), false),
              _buildNavigationBarItem(
                  "explore", const Icon(CupertinoIcons.person), false)
            ]));
  }

  Color currentColor() {
    return controller.currentTab.value == MainTabs.explore
        ? ColorConstants.appColor
        : ColorConstants.appGrey;
  }

  List<Widget> _buildScreens() {
    return const [ExploreTab(), ChatTab(), FavouriteTab(), ProfileTab()];
  }

  // TODO: Add this in widgets
  PersistentBottomNavBarItem _buildNavigationBarItem(
      String label, Icon iconData, bool isSVG,
      {String? svgPath = AssetsPath.svgAppLogo, Color? currentColor}) {
    svgPath = AssetsPath.svgAppLogo;

    return PersistentBottomNavBarItem(
      icon: isSVG
          ? ColorFiltered(
              colorFilter: ColorFilter.mode(
                currentColor!, // The color you want to apply
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(svgPath),
            )
          : iconData,
      title: label,
      activeColorPrimary: ColorConstants.appColor,
      inactiveColorPrimary: ColorConstants.appGrey,
    );
  }
}
