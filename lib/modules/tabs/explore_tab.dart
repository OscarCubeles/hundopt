import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/app_bar.dart';
import '../../shared/constants/string_constants.dart';
import '../../shared/widgets/app_page.dart';
import '../home/home_controller.dart';

class ExploreTab extends GetView<HomeController> {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(child: Text("Explore"), showAppBar: false,);

  }
}