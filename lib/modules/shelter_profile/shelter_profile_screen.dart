import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/shelter_profile/shelter_profile.dart';
import 'package:like_button/like_button.dart';

import '../../shared/constants/colors.dart';
import '../../shared/widgets/app_bar.dart';
import '../../shared/widgets/horizontal_bar.dart';

class ShelterProfileScreen extends GetView<ShelterProfileController> {
  const ShelterProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            color: ColorConstants.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: ColorConstants.appColor,
                        onPressed: () => print("back pressed"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.shelter.name,
                              style: Theme.of(context).textTheme.headlineSmall),
                          SizedBox(height: 16,),
                          LikeButton()
                          /*Text(
                        controller.fullName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )*/
                        ],
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/perrera-test.png'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/dog.png", height: 35),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Perros en Adopción",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                ),
                HorizontalBar(),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      children: List.generate(20, (index) {
                        return GridTile(
                          child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width, // set maximum
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: SizedBox.fromSize(
                                        child: AspectRatio(
                                          child: Image.asset(
                                            'assets/images/example_dog.jpg',
                                            fit: BoxFit.cover,
                                            width: 84.0,
                                            height: 84.0,
                                          ),
                                          aspectRatio: 1 / 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Text(
                                      "Kira",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  )
                                ],
                              )),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
