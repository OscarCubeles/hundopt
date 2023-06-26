import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import '../../shared/shared.dart';
import 'home_controller.dart';

/// The [HomeScreen] class representing the screen the boilerplate for all the tab screens
///
/// This class displays the tab menu on the bottom of the screen and sets the current screen to the pressed tab screen
class HomeScreen extends GetView<HomeController> {
  /// Constructs a new instance of the [HomeScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const HomeScreen({super.key});

  /// Builds the widget tree for the chat screen.
  ///
  /// This method returns an [WillPopScope] widget containing an observable child from [_buildWidget]
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => _buildWidget(context)),
    );
  }

  /// Builds the widget tree for the chat screen.
  ///
  /// This method returns an [Scaffold] widget an [AppTabBar] with all the screens on the tab bar
  Widget _buildWidget(BuildContext context) {
    return Scaffold(
      body: AppTabBar(
          controller: controller.persistentTabController,
          screens: _buildScreens(),
          onItemSelected: (index) => controller.switchTab(index),
          currentItemColor: currentColor()),
    );
  }

  /// Sets the current  icon color from the tab bar depending whether the tab is pressed or not
  Color currentColor() {
    return controller.currentTab.value == MainTabs.explore
        ? ColorConstants.appColor
        : ColorConstants.appGrey;
  }

  /// This method returns the list of screens on the tab bar
  List<Widget> _buildScreens() {
    return const [ExploreTab(), ChatTab(), FavouriteTab(), ProfileTab()];
  }
}
