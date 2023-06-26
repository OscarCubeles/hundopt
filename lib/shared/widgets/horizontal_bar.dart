import 'package:flutter/material.dart';
import '../constants/constants.dart';

/// The [HorizontalBar] class creates custom widget that displays a horizontal bar with an optional left or right colored section.
class HorizontalBar extends StatelessWidget {
  /// A boolean value that determines whether the colored section of the bar is on the left or right.
  final bool isLeft;

  /// Constructs a new instance of the [HorizontalBar] class with the specified parameters.
  ///
  /// The [isLeft] parameter must not be null.
  const HorizontalBar({super.key, required this.isLeft});

  /// Builds the `HorizontalBar` widget.
  ///
  /// This method returns a `SizedBox` widget that contains a `Stack` widget with a black line and an optional colored section.
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
            ),
          ),
          isLeft ? printLeftBar(width) : printRightBar(width)
        ],
      ),
    );
  }

  /// Builds the colored section of the bar on the left side.
  ///
  /// This method returns a `Positioned` widget that contains a colored `Container` widget.
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
      ),
    );
  }

  /// Builds the colored section of the bar on the right side.
  ///
  /// This method returns a `Positioned` widget that contains a colored `Container` widget.
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
      ),
    );
  }
}
