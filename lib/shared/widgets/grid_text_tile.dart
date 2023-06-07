import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/styles.dart';

class GridTextTile extends StatelessWidget {
  final double width;
  final String title;
  final String text;

  const GridTextTile(
      {super.key,
      required this.width,
      required this.title,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 3 - 20,
      height: 80,
      decoration: BoxDecoration(
        color: ColorConstants.transparentAppColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Styles.gridTileText,
          ),
          SizedBox(height: 10),
          Text(text, style: Styles.gridTileText),
        ],
      ),
    );
  }
}
