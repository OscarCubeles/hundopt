import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../home_controller.dart';

class FavouriteTab extends GetView<HomeController> {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text("Favourite")

    );
  }
}