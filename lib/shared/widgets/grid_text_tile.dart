import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';

/// The [GridTextTile] class creates custom widget that displays a text tile in a grid.
class GridTextTile extends StatelessWidget {
  /// The width of the tile.

  /// The width of the tile.
  final double width;

  /// The title of the tile.
  final String title;

  /// The text to display in the tile.
  final String text;

  /// Constructs a new instance of the [GridTextTile] class with the specified parameters.
  ///
  /// The [width], [title], and [text] parameters must not be null.
  const GridTextTile(
      {super.key,
      required this.width,
      required this.title,
      required this.text});

  /// Builds the `GridTextTile` widget.
  ///
  /// This method returns a `Container` widget that contains the title and text.
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
          const SizedBox(height: 10),
          Text(text, style: Styles.gridTileText),
        ],
      ),
    );
  }
}
