import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/tabs/favourite/favourite_tab_controller.dart';
import 'package:hundopt/shared/constants/colors.dart';
import 'package:hundopt/shared/widgets/scrollable_grid.dart';

import '../../../../shared/widgets/app_bar.dart';
import '../../../shared/constants/string_constants.dart';
import '../../../shared/constants/styles.dart';
import '../../../shared/widgets/app_page.dart';
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
                  unselectedLabelColor: Colors.black, // set the color for inactive tabs
                  labelColor: Colors.white, // set the color for the active tab
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
                        ScrollableGrid(onLikeTap: () {  }, onTileTab: () {  },),
                        ScrollableGrid(onLikeTap: () {  }, onTileTab: () {  },)
                      ])
              )
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