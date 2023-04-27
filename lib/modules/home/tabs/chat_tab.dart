import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/shared/constants/colors.dart';

import '../home_controller.dart';

class ChatTab extends GetView<HomeController> {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text("chat",
        style: TextStyle(
          color: ColorConstants.appColor
        ),),
    );
  }
}