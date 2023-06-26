import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants/colors.dart';

/// The [ProgressBar] class creates custom widget that displays a progress bar with a back button and a close button.
class ProgressBar extends StatelessWidget {
  /// A callback function that is called when the back button is pressed.
  final VoidCallback onBackPressed;

  /// A callback function that is called when the close button is pressed.
  final VoidCallback onClosePressed;

  /// An observable double value that represents the progress of the bar.
  final RxDouble progress;

  /// Constructs a new instance of the [ProgressBar] class with the specified parameters.
  ///
  /// The [onBackPressed], [onClosePressed], and [progress] parameters must not be null.
  const ProgressBar(
      {super.key,
      required this.onBackPressed,
      required this.onClosePressed,
      required this.progress});

  /// Builds the `ProgressBar` widget.
  ///
  /// This method returns a `Padding` widget that contains a `SizedBox` widget with a `Row` widget that has a back button, a progress bar, and a close button.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onBackPressed,
                splashColor: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                child: Icon(
                  Icons.arrow_back,
                  color: ColorConstants.appColor,
                  size: 24,
                ),
              ),
            ),
            SizedBox(
              height: 8,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Obx(
                  () => LinearPercentIndicator(
                    backgroundColor: ColorConstants.formBarBackground,
                    progressColor: ColorConstants.appColor,
                    percent: progress.value,
                    lineHeight: 8.0,
                    barRadius: const Radius.circular(10),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onClosePressed,
                splashColor: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                child: Icon(
                  Icons.close,
                  color: ColorConstants.appColor,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
