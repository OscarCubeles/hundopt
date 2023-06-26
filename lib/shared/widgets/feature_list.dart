import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';

/// The [FeatureList] class creates custom widget that displays a list of features.
class FeatureList extends StatelessWidget {
  /// The width of the widget.
  final double width;

  /// The list of positive features.
  final List<String> positiveFeatures;

  /// The list of negative features.
  final List<String> negativeFeatures;

  /// Constructs a new instance of the [FeatureList] class with the specified parameters.
  ///
  /// The [width], [positiveFeatures], and [negativeFeatures] parameters must not be null.
  const FeatureList({
    super.key,
    required this.width,
    required this.positiveFeatures,
    required this.negativeFeatures,
  });

  /// Builds the `FeatureList` widget.
  ///
  /// This method returns a `SizedBox` widget that contains a `Row` widget.
  /// The `Row` widget contains two `SizedBox` widgets that display the positive and negative features.
  /// The `_buildFeature` method is used to build each feature.
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

  /// Builds a feature widget.
  ///
  /// This method returns a `Row` widget that contains an icon and a text.
  Widget _buildFeature(
      IconData icon, String featureName, Color color, TextStyle style) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: color)),
        Text(featureName, style: style),
      ],
    );
  }
}
