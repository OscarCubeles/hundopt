import 'package:flutter/material.dart';

import '../constants/constants.dart';

class HorizontalBar extends StatelessWidget {
  final bool isLeft;

  const HorizontalBar({super.key, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return SizedBox(
      width: width,
      height: 10,
      child: Stack(
          children: [
          Positioned(
          bottom: 5,
          child: Container(
            width: width,
            color: Colors.black,
            height: 1,
          )),
      isLeft ? printLeftBar(width) : printRightBar(width)
      ],
    ),);
  }

  Widget printLeftBar(double screenWidth) {
    return Positioned(
        height: 10,
        left: 10,
        child: Container(
          width: screenWidth * 0.45,
          height: 10,
          decoration: BoxDecoration(
            color: ColorConstants.appColor,
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );
  }

  Widget printRightBar(double screenWidth) {
    return Positioned(
        height: 10,
        right: 10,
        child: Container(
          width: screenWidth * 0.45,
          height: 10,
          decoration: BoxDecoration(
            color: ColorConstants.appColor,
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );
  }

}