import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/settings/settings_controller.dart';
import '../../shared/shared.dart';

class AdoptStepsScreen extends GetView<SettingsController> {
  const AdoptStepsScreen({super.key});

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
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
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
                                            child: Text(
                                                (index + 1).toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            7.5, 8.5, 0, 0),
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
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
