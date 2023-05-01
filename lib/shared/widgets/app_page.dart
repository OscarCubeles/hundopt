import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'app_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final bool showAppBar;
  final bool showSettings;
  final VoidCallback? onSettingsPressed;
  const AppScaffold({super.key, required this.child, required this.showAppBar, this.showSettings = false, this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: showAppBar ?  MainAppBar(showSettings: showSettings,onSettingsPressed: onSettingsPressed,) : null,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: ColorConstants.background,
              child: child

          )
        ])));
  }
}
