import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import '../../shared/shared.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => _buildWidget(context)),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return Scaffold(
      body: AppTabBar(
          controller: controller.persistentTabController,
          screens: _buildScreens(),
          onItemSelected: (index) => controller.switchTab(index),
          currentItemColor: currentColor()),
    );
  }

  Color currentColor() {
    return controller.currentTab.value == MainTabs.explore
        ? ColorConstants.appColor
        : ColorConstants.appGrey;
  }

  List<Widget> _buildScreens() {
    return const [ExploreTab(), ChatTab(), FavouriteTab(), ProfileTab()];
  }
}
