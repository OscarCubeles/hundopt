import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../constants/constants.dart';

/// The [AppTabBar] class custom tab bar widget that displays a list of screens and allows the user to switch between them.
class AppTabBar extends StatelessWidget {
  /// The [screens] parameter is a list of widgets to display as screens in the tab bar.
  final List<Widget> screens;

  /// The [onItemSelected] parameter is a function to call when the user selects a screen.
  final Function(int)? onItemSelected;

  /// The [currentItemColor] parameter is the color to use for the currently selected screen.
  final Color currentItemColor;

  /// The [controller] parameter is the controller to use for the tab bar.
  final PersistentTabController controller;

  /// Constructs a new instance of the [AppTabBar] class with the specified parameters.
  ///
  /// The [screens], [onItemSelected], [controller] and
  /// [currentItemColor] parameters must not be null.
  const AppTabBar(
      {super.key,
      required this.screens,
      required this.onItemSelected,
      required this.currentItemColor,
      required this.controller});

  /// Builds the app tab bar widget using a [PersistentTabView] widget.
  ///
  /// The [context] parameter is the build context.
  /// The [screens] parameter is a list of widgets to display as screens.
  /// The [onItemSelected] parameter is a function to call when a tab is selected.
  /// The [currentItemColor] parameter is the color to apply to the selected tab.
  /// The [controller] parameter is the controller for the [PersistentTabView].
  ///
  /// Returns a [Container] widget containing the [PersistentTabView] widget.
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(context,
        controller: controller,
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
        ]);
  }

  /// Builds a [PersistentBottomNavBarItem] widget for the app tab bar.
  ///
  /// The [label] parameter is the label text to display on the navigation bar item.
  /// The [iconData] parameter is the icon data to display on the navigation bar item.
  /// The [isSVG] parameter is a boolean that indicates whether the icon is an SVG image.
  /// The [svgPath] parameter is the path to the SVG image file, if applicable.
  /// The [currentColor] parameter is the color to apply to the icon, if it is an SVG image.
  ///
  /// Returns a [PersistentBottomNavBarItem] widget with the specified label, icon, and color.
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
