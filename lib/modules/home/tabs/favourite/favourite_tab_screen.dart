import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:like_button/like_button.dart';
import '../../../../shared/shared.dart';

/// The [FavouriteTab] class representing the screen with a list in a grid fashion
/// of all the user favourite shelters and dogs
class FavouriteTab extends GetView<FavouriteController> {
  /// Constructs a new instance of the [FavouriteTab] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const FavouriteTab({super.key});

  /// Builds the widget tree for the favourite screen.
  ///
  /// This method returns an [FavouriteTab] widget containing a [AppScaffold] widget
  /// with a [SizedBox] with a [TabBar] where the user can select to see the list of favourite
  /// shelters or dogs displayed in a [GridView] inside a [SingleChildScrollView].
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringConstants.favouriteLabel,
                  style: Theme.of(context).textTheme.headlineLarge),
              const Padding(padding: EdgeInsets.all(5)),
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
                  tabs: const [
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                children: List.generate(
                                    controller.favDogs.length, (index) {
                                  return GestureDetector(
                                      onTap: () => {
                                            controller.navigateToDogInfo(
                                                controller.favDogs[index]),
                                          },
                                      child: GridTile(
                                        child: Container(
                                            margin: const EdgeInsets.fromLTRB(
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
                                                        aspectRatio: 1 / 1,
                                                        child: Image.network(
                                                            controller
                                                                .favDogs[index]
                                                                .mainPictureURL,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .favDogs[index].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium,
                                                    ),
                                                    Obx(
                                                      () => LikeButton(
                                                          onTap:
                                                              (bool isLiked) {
                                                            controller
                                                                .toggleDogLikeStatus(
                                                                    controller
                                                                            .favDogs[
                                                                        index]);
                                                            return Future.value(
                                                                !isLiked);
                                                          },
                                                          isLiked: controller
                                                              .isDogLiked(
                                                                  controller
                                                                      .favDogs[
                                                                          index]
                                                                      .id)),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ));
                                }),
                              ),
                            )),
                        Obx(() => SingleChildScrollView(
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                children: List.generate(
                                    controller.favShelters.length, (index) {
                                  return GestureDetector(
                                      onTap: () => {
                                            controller.navigateToShelter(
                                                controller.favShelters[index])
                                          },
                                      // Add a function to move to the dog or shelter
                                      child: GridTile(
                                        child: Container(
                                            margin: const EdgeInsets.fromLTRB(
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
                                                        aspectRatio: 1 / 1,
                                                        child: Image.network(
                                                            controller
                                                                .favShelters[
                                                                    index]
                                                                .pictureURL,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          controller
                                                              .favShelters[
                                                                  index]
                                                              .name,
                                                          style: Styles
                                                              .headlineShelterMedium,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Obx(
                                                        () => LikeButton(
                                                          onTap:
                                                              (bool isLiked) {
                                                            controller
                                                                .toggleShelterLikeStatus(
                                                                    controller
                                                                            .favShelters[
                                                                        index]);
                                                            return Future.value(
                                                                !isLiked);
                                                          },
                                                          isLiked: controller
                                                              .isShelterLiked(
                                                                  controller
                                                                      .favShelters[
                                                                          index]
                                                                      .id),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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
