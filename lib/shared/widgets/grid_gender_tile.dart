import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/styles.dart';

class GridGenderTile extends StatelessWidget {
  final double width;
  final String gender;

  const GridGenderTile(
      {super.key,
      required this.width,
      required this.gender});

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
            "Género",
            style: Styles.gridTileText
          ),
          const SizedBox(height: 10),
          gender == "Macho"
              ? Icon(
                  Icons.male,
                  size: 20,
                  color: Colors.white,
                )
              : Icon(
                  Icons.female,
                  size: 20,
                  color: Colors.white,
                ),
        ],
      ),
    );
  }
}
