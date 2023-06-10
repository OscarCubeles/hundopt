import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:like_button/like_button.dart';

import '../../models/dog.dart';

class ScrollableDogGrid extends StatelessWidget {
  const ScrollableDogGrid(
      {super.key,
      required this.onLikeTap,
      required this.onTileTab,
      required this.dogs});

  final VoidCallback onLikeTap;
  final VoidCallback onTileTab;
  final RxList dogs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        children: List.generate(dogs.length, (index) {
          return GestureDetector(
              onTap: () => print("Tile pressed $index"),
              // Add a function to move to the dog or shelter
              child: GridTile(
                child: Container(
                    margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width, // set maximum
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SizedBox.fromSize(
                              child: AspectRatio(
                                child: Image.network(
                                    dogs[index].mainPictureURL,
                                    fit: BoxFit.fill),
                                aspectRatio: 1 / 1,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dogs[index].name,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              LikeButton(
                                isLiked: true, // TODO: Change this accordingly with the like state value
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ));
        }),
      ),
    );
  }
}
