import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/dog_info/dog_info.dart';
import 'package:hundopt/shared/shared.dart';

/// The [DogReservedScreen] class representing the screen informing the user that
/// a dog has been reserved in the Hundopt app.
///
/// This class displays all the dog name along with some information regarding the reservation of the dog.
class DogReservedScreen extends GetView<DogInfoController> {
  /// Constructs a new instance of the [DogReservedScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const DogReservedScreen({super.key});

  /// Builds the widget tree for the register screen.
  ///
  /// This method returns an [AppScaffold] widget containing a [SingleChildScrollView] widget
  /// with different widgets to display text information of the reservation of the dog
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
                    "¡${controller.currentDog().name}${StringConstants.titleReservedText}",
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
                        return Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(padding: EdgeInsets.all(10)),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: ColorConstants.appColor,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text((index + 1).toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            7.5, 8.5, 0, 0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                        ),
                                      ),
                                    ])
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                AppPrimaryButton(
                    text: StringConstants.continueContactLabel,
                    onPressed: controller.reserveAndContinue),
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
