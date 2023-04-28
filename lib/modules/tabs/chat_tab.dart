import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/shared.dart';

import '../../routes/app_pages.dart';
import '../home/home_controller.dart';

class ChatTab extends GetView<HomeController> {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(child: Text("Chat"), showAppBar: true);
  }
}
