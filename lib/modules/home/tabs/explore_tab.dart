import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../shared/constants/colors.dart';
import '../home_controller.dart';

class ExploreTab extends GetView<HomeController> {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text("Explore",
      style: TextStyle(
          color: ColorConstants.appColor
      ),),
    );
  }
}