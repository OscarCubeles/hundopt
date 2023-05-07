import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/individual_chat/individual_chat_controller.dart';

class IndividualChatScreen extends GetView<IndividualChatController>{
  const IndividualChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Single chat"),
    );
  }

}