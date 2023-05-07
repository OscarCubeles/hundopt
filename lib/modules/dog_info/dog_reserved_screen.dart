import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/dog_info/dog_info.dart';
import 'package:hundopt/shared/shared.dart';

class DogReservedScreen extends GetView<DogInfoController> {
  const DogReservedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "¡${controller.dog.name}${StringConstants.titleReservedText}",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.01)),
                Text(
                  StringConstants.bodyReservedText,
                  style: Styles.bodySmall,
                  textAlign: TextAlign.justify,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                      itemCount: 5,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.all(10)),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: ColorConstants.appColor,
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  (index + 1).toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall),
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              7.5, 8.5, 0, 0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                            children: [
                                              Text(
                                                  StringConstants
                                                      .adoptSteps[index],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium),
                                              Text(
                                                StringConstants
                                                    .adoptStepsDetail[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                          ),
                                        ),
                                      ])
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                AppPrimaryButton(
                    text: StringConstants.continueContactLabel,
                    onPressed: controller.navigateToSingleChat),
                Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.01)),
                ClickableText(
                    uText: StringConstants.cancelLabel,
                    text: "",
                    onPressed: controller.navigateBack)
              ],
            ),
          ),
        ));
  }
}
