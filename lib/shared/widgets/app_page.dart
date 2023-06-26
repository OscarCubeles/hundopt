import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'app_bar.dart';

/// The [AppScaffold] class creates custom scaffold widget for the app.
class AppScaffold extends StatelessWidget {
  /// The child widget to display in the scaffold.
  final Widget child;

  /// Whether to show the app bar.
  final bool showAppBar;

  /// Whether to show the settings icon in the app bar.
  final bool showSettings;

  /// Constructs a new instance of the [AppScaffold] class with the specified parameters.
  ///
  /// The [child], [showAppBar], and [showSettings] parameters must not be null.
  const AppScaffold(
      {super.key,
      required this.child,
      required this.showAppBar,
      this.showSettings = false});

  /// Builds the `AppScaffold` widget.
  ///
  /// This method returns a `Scaffold` widget that contains a `MainAppBar`
  /// widget if `showAppBar` is `true`.
  /// The `body` of the `Scaffold` widget is a `SingleChildScrollView` widget
  /// that contains a `Column` widget with a `Container` widget that displays
  /// the `child` widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: showAppBar
            ? MainAppBar(
                showSettings: showSettings,
              )
            : null,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: ColorConstants.background,
              child: child)
        ])));
  }
}
