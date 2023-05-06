import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/dog_info/dog_info_controller.dart';

class DogInfoScreen extends GetView<DogInfoController>{
  const DogInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(controller.dog.name),
    );
  }

}