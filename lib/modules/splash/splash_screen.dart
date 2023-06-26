import 'package:flutter/material.dart';
import 'package:hundopt/shared/shared.dart';

/// The [SplashScreen] class representing the screen showed to the user when this
/// opens the app. It contains the logo of Hündopt
class SplashScreen extends StatelessWidget {
  /// Constructs a new instance of the [ShelterProfileScreen] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const SplashScreen({super.key});

  /// Builds the widget tree for the personality form questions screen.
  ///
  /// This method returns a [Container] widget containing a [Image.asset] widget
  /// with the logo of Hündopt
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: ColorConstants.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsPath.appLogo),
        ],
      ),
    );
  }
}
