import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/constants/colors.dart';

class FavouriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TextStyle centreLabelStyle;
  late TextStyle dogLabelStyle;
  late Color centreBtnColor;
  late Color dogBtnColor;

  late TabController tabBarController;
  var _selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    centreBtnColor = Colors.black;
    dogBtnColor = ColorConstants.appColor;
    tabBarController = TabController(length: 2, vsync: this);
    tabBarController.addListener(() {
      _selectedIndex.value = tabBarController.index;
    });
  }

  void swapColors() {}

  void centreBtnPressed() {}

  void dogBtnPressed() {}
}
