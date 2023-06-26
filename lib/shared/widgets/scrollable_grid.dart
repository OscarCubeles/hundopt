import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

/// The [ScrollableGrid] class creates custom widget that displays a scrollable grid of dogs with their names and main pictures.
class ScrollableGrid extends StatelessWidget {
  /// Constructs a new instance of the [ScrollableGrid] class with the specified parameters.
  ///
  /// The [onLikeTap] and [onTileTab] parameters must not be null.
  const ScrollableGrid(
      {super.key, required this.onLikeTap, required this.onTileTab});

  /// A callback function that is called when the like button is tapped.
  final VoidCallback onLikeTap;

  /// A callback function that is called when a tile is tapped.
  final VoidCallback onTileTab;

  /// Builds the `ScrollableGrid` widget.
  ///
  /// This method returns a `SingleChildScrollView` widget that contains a `GridView.count` widget with a specified number of columns and a child aspect ratio.
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        children: List.generate(20, (index) {
          return GestureDetector(
              // Add a function to move to the dog or shelter
              child: GridTile(
            child: Container(
                margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width, // set maximum
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SizedBox.fromSize(
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.asset('assets/images/example_dog.jpg',
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Kira",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const LikeButton()
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
