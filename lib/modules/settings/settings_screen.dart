import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/settings/settings.dart';

import '../../shared/constants/constants.dart';
import '../../shared/widgets/app_page.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConstants.background,
        child: SafeArea(
          child: AppScaffold(
              showAppBar: false,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: controller.navigateToHome,
                                splashColor: Colors.grey,
                                borderRadius: BorderRadius.circular(30),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: ColorConstants.appColor,
                                  size: 24,
                                ),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 88,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      StringConstants.configurationLabel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )
                                  ],
                                )),
                            Spacer(),
                          ],
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.settingOptions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: ListTile(
                                onTap: controller.settingOptions[index].onPressed,
                                title: Text(
                                  controller.settingOptions[index].text,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                trailing: Icon(controller
                                    .settingOptions[index].iconSource),
                              ),
                            );
                          })),
                ],
              )),
        ));
  }
}
