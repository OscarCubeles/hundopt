import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IndividualChatController extends GetxController{
  final ScrollController scrollController = ScrollController();

  @override
  void onReady() {
    scrollToBottom();
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 1),
      curve: Curves.easeOut,
    );
  }

}