import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/tabs/favourite/favourite_tab_controller.dart';
import 'package:hundopt/shared/constants/colors.dart';
import 'package:hundopt/shared/widgets/scrollable_grid.dart';
import 'package:like_button/like_button.dart';

import '../../../../shared/widgets/app_bar.dart';
import '../../../shared/constants/string_constants.dart';
import '../../../shared/constants/styles.dart';
import '../../../shared/widgets/app_page.dart';
import '../../../shared/widgets/scrollable_dog_grid.dart';
import '../../home/home_controller.dart';

class FavouriteTab extends GetView<FavouriteController> {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringConstants.favouriteLabel,
                  style: Theme.of(context).textTheme.headlineLarge),
              Padding(padding: EdgeInsets.all(5)),
              TabBar(
                  isScrollable: true,
                  unselectedLabelStyle: Styles.labelInactive,
                  labelStyle: Styles.labelActive,
                  unselectedLabelColor: Colors.black,
                  // set the color for inactive tabs
                  labelColor: Colors.white,
                  // set the color for the active tab
                  controller: controller.tabBarController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(35), // Creates border
                    color: ColorConstants.appColor,
                  ),
                  tabs: [
                    Tab(
                        child: Text(
                      StringConstants.dogLabel,
                    )),
                    Tab(
                        child: Text(
                      StringConstants.centreLabel,
                    ))
                  ]),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                      controller: controller.tabBarController,
                      children: [
                        Obx(() => SingleChildScrollView(
                              child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                children: List.generate(
                                    controller.favDogs.length, (index) {
                                  return GestureDetector(
                                      onTap: () => print("Tile pressed $index"),
                                      // Add a function to move to the dog or shelter
                                      child: GridTile(
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                5, 20, 5, 0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width, // set maximum
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: SizedBox.fromSize(
                                                      child: AspectRatio(
                                                        child: Image.network(
                                                            controller
                                                                .favDogs[index]
                                                                .mainPictureURL,
                                                            fit: BoxFit.cover),
                                                        aspectRatio: 1 / 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .favDogs[index]
                                                            .name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineMedium,
                                                      ),
                                                      LikeButton(
                                                        isLiked:
                                                            true, // TODO: Change this accordingly with the like state value
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                      ));
                                }),
                              ),
                            )),
                        Obx(() => SingleChildScrollView(
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            children: List.generate(
                                controller.favShelters.length, (index) {
                              return GestureDetector(
                                  onTap: () => print("Tile pressed $index"),
                                  // Add a function to move to the dog or shelter
                                  child: GridTile(
                                    child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            5, 20, 5, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width, // set maximum
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                                child: SizedBox.fromSize(
                                                  child: AspectRatio(
                                                    child: Image.network(
                                                        controller
                                                            .favShelters[index]
                                                            .pictureURL,
                                                        fit: BoxFit.cover),
                                                    aspectRatio: 1 / 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                        .favShelters[index]
                                                        .name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium,
                                                  ),
                                                  LikeButton(
                                                    isLiked:
                                                    true, // TODO: Change this accordingly with the like state value
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ));
                            }),
                          ),
                        ))
                        
                      ]))
            ],
          ),
        ));
  }
}

/*
Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: controller.dogBtnPressed,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                        decoration: BoxDecoration(
                            color: ColorConstants.appColor,
                            border: Border.all(
                              color: ColorConstants.appColor,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          StringConstants.dogLabel,
                          style: Theme.of(context).textTheme.headlineSmall,
                        )),
                  ),
                  GestureDetector(
                    onTap: controller.centreBtnPressed,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                        decoration: BoxDecoration(
                            color: ColorConstants.appColor,
                            border: Border.all(
                              color: ColorConstants.appColor,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          StringConstants.centreLabel,
                          style: Theme.of(context).textTheme.displaySmall,
                        )),
                  )
                ],
              ),
 */
