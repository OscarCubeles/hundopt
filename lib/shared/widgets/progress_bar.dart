import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants/colors.dart';

class ProgressBar extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onClosePressed;
  final RxDouble progress;

  const ProgressBar(
      {super.key,
      required this.onBackPressed,
      required this.onClosePressed,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                        barRadius: Radius.circular(10),
                      ),
                    ),
                  )),
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
        ));
  }
}
