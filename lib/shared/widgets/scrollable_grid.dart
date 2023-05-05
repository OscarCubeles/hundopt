import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ScrollableGrid extends StatelessWidget{
  const ScrollableGrid({super.key, required this.onLikeTap, required this.onTileTab});
  final VoidCallback onLikeTap;
  final VoidCallback onTileTab;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: List.generate(20, (index) {
            return GridTile(
              child: Container(
                  margin: EdgeInsets.fromLTRB(5,20,5,0),
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
                              child: Image.asset('assets/images/example_dog.jpg', fit: BoxFit.fill),
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
                            Text("Kira", style: Theme.of(context).textTheme.headlineMedium,),
                            LikeButton()
                          ],
                        ),
                      )
                    ],
                  )),
            );
          }),
        ),
      );
  }
}