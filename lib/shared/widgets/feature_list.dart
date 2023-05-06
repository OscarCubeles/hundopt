import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/dog_feature.dart';
import '../constants/colors.dart';

class FeatureList extends StatelessWidget{
  final double width;
  final List<DogFeature> positiveFeatures;
  final List<DogFeature> negativeFeatures;


  const FeatureList({super.key, required this.width, required this.positiveFeatures, required this.negativeFeatures});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: positiveFeatures.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildFeature(
                      CupertinoIcons.checkmark_square_fill,
                      positiveFeatures[index].name,
                      ColorConstants.appColor,
                      Theme.of(context).textTheme.bodySmall!,
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
              children: [
                ListView.builder(
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: negativeFeatures.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildFeature(
                      CupertinoIcons.clear_fill,
                      negativeFeatures[index].name,
                      Colors.red,
                      Theme.of(context).textTheme.bodySmall!,
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



/*
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.9,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.4,
              child: Column(
                children: [
                  _buildFeature(
                      CupertinoIcons.checkmark_square_fill,
                      "Perros Macho",
                      ColorConstants.appColor,
                      Theme.of(context).textTheme.bodySmall!),
                  _buildFeature(
                      CupertinoIcons.checkmark_square_fill,
                      "Perros Hembra",
                      ColorConstants.appColor,
                      Theme.of(context).textTheme.bodySmall!)
                ],
              ),
            ),
            SizedBox(
              width: width*0.4,
              child: Column(
                children: [
                  _buildFeature(
                      CupertinoIcons.clear_fill,
                      "Gatos Macho",
                      Colors.red,
                      Theme.of(context).textTheme.bodySmall!),
                  _buildFeature(
                      CupertinoIcons.clear_fill,
                      "Gatos Hembra",
                      Colors.red,
                      Theme.of(context).textTheme.bodySmall!)
                ],
              ),
            )
          ]),
    );
  }*/

  Widget _buildFeature(
      IconData icon, String featureName, Color color, TextStyle style) {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Icon(icon, color: color)),
        Text(featureName, style: style),
      ],
    );
  }

}