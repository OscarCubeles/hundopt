import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/styles.dart';

class FeatureList extends StatelessWidget {
  final double width;
  final List<String> positiveFeatures;
  final List<String> negativeFeatures;

  const FeatureList(
      {super.key,
      required this.width,
      required this.positiveFeatures,
      required this.negativeFeatures});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.builder(
                  padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
                  shrinkWrap: true,
                  itemCount: positiveFeatures.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildFeature(
                      CupertinoIcons.checkmark_square_fill,
                      positiveFeatures[index],
                      ColorConstants.appColor,
                      Styles.featureText,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.builder(
                  padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
                  shrinkWrap: true,
                  itemCount: negativeFeatures.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildFeature(
                      CupertinoIcons.clear_fill,
                      negativeFeatures[index],
                      Colors.red,
                      Styles.featureText,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFeature(
      IconData icon, String featureName, Color color, TextStyle style) {
    return Row(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Icon(icon, color: color)),
        Text(featureName, style: style),
      ],
    );
  }
}
