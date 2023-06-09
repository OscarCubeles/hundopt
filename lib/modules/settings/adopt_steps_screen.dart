import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/settings/settings_controller.dart';
import '../../shared/shared.dart';

/// The [AdoptStepsScreen] class representing the screen with the list of steps
/// that a user must follow in order to adopt a dog using Húndopt
class AdoptStepsScreen extends GetView<SettingsController> {
  /// Constructs a new instance of the [AdoptStepsScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const AdoptStepsScreen({super.key});

  /// Builds the widget tree for the settings screen.
  ///
  /// This method returns a [AppScaffold] widget containing a [SingleChildScrollView] widget
  /// with a [SafeArea] that has [Column] widget that contains the text describing all the adopting
  /// steps that a user has to follow in order to adopt a dog using Hündopt
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
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
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, 0, MediaQuery.of(context).size.height * 0.075)),
                AppPrimaryButton(
                    text: StringConstants.continueContactLabel,
                    onPressed: controller.navigateBack),
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
