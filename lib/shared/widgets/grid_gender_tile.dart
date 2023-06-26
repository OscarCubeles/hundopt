import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';

/// The [GridGenderTile] class creates custom widget that displays a gender tile in a grid.
class GridGenderTile extends StatelessWidget {
  /// The width of the tile.
  final double width;

  /// The gender to display in the tile.
  final String gender;

  /// Constructs a new instance of the [GridGenderTile] class with the specified parameters.
  ///
  /// The [width] and [gender] parameters must not be null.
  const GridGenderTile({
    super.key,
    required this.width,
    required this.gender,
  });

  /// Builds the `GridGenderTile` widget.
  ///
  /// This method returns a `Container` widget that contains the gender icon and text.
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
          Text("Género", style: Styles.gridTileText),
          const SizedBox(height: 10),
          gender == "Macho"
              ? const Icon(
                  Icons.male,
                  size: 20,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.female,
                  size: 20,
                  color: Colors.white,
                ),
        ],
      ),
    );
  }
}
