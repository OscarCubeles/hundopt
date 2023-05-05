import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../constants/constants.dart';

class AppTabBar extends StatelessWidget {
  final List<Widget> screens;
  final Function(int)? onItemSelected;
  final Color currentItemColor;

  const AppTabBar(
      {super.key,
      required this.screens,
      required this.onItemSelected,
      required this.currentItemColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PersistentTabView(context,
            screens: screens,
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
            onItemSelected: onItemSelected,
            items: [
          _buildNavigationBarItem(
              StringConstants.appName, const Icon(CupertinoIcons.home), true,
              svgPath: AssetsPath.svgAppLogo, currentColor: currentItemColor),
          _buildNavigationBarItem(StringConstants.chatLabel,
              const Icon(CupertinoIcons.chat_bubble_2), false),
          _buildNavigationBarItem(StringConstants.favouriteLabel,
              const Icon(CupertinoIcons.heart), false),
          _buildNavigationBarItem(StringConstants.profileLabel,
              const Icon(CupertinoIcons.person), false)
        ]));
  }

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
