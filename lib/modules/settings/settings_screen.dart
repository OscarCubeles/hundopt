import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/settings/settings.dart';
import '../../shared/shared.dart';

/// The [SettingsScreen] class representing the screen with the list of all actions
/// that the user can do in the settings the personality
class SettingsScreen extends GetView<SettingsController> {
  /// Constructs a new instance of the [SettingsScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const SettingsScreen({super.key});

  /// Builds the widget tree for the settings screen.
  ///
  /// This method returns a [Container] widget containing a [SafeArea] widget
  /// with a [AppScaffold] that has [Column] widget containing a [SettingsBar] and a
  /// [ListView] with all the options that the user can do in the settings screen
  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConstants.background,
        child: SafeArea(
          child: AppScaffold(
              showAppBar: false,
              child: Column(
                children: [
                  SettingsBar(
                    onTap: controller.navigateToHome,
                    icon: Icons.arrow_back,
                    titleLabel: StringConstants.configurationLabel,
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.settingOptions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: ListTile(
                                onTap:
                                    controller.settingOptions[index].onPressed,
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
