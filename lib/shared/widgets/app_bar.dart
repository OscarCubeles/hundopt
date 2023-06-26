import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/assets_path.dart';
import '../constants/string_constants.dart';

/// The [MainAppBar] class creates custom app bar widget for the main screen.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Whether to show the settings icon.
  final bool showSettings;

  /// A callback function for when the settings icon is pressed.
  final VoidCallback? onSettingsPressed;

  /// Whether to show the like button.
  final bool? showLike;

  /// A callback function for when the like button is pressed.
  final VoidCallback? onLikePressed;

  /// Constructs a new instance of the [MainAppBar] class with the specified parameters.
  ///
  /// The [showSettings] parameter determines whether to show the settings icon.
  /// The [onSettingsPressed] parameter is a callback function for when the settings icon is pressed.
  /// The [showLike] parameter determines whether to show the like button.
  /// The [onLikePressed] parameter is a callback function for when the like button is pressed.
  const MainAppBar(
      {super.key,
      this.showSettings = false,
      this.onSettingsPressed,
      this.showLike,
      this.onLikePressed});

  /// Builds the `MainAppBar` widget.
  ///
  /// This method returns a `SafeArea` widget that contains a `Container` widget with a `Stack` widget.
  /// The `Row` widget contains the app logo, app name, and settings icon.
  /// The `settingsIcon` method returns the settings icon if `showSettings` is `true`.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AssetsPath.appLogo,
                        fit: BoxFit.contain, height: 45),
                    const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                    Text(
                      StringConstants.appName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    settingsIcon()
                  ],
                )
              ],
            ),
          )),
    );
  }

  /// Returns the settings icon.
  ///
  /// This method returns the settings icon as a `GestureDetector` widget if `showSettings` is `true`.
  /// The `onTap` callback is set to `onSettingsPressed`.
  /// The `SvgPicture` widget displays the settings icon.
  /// If `showSettings` is `false`, this method returns an empty `Padding` widget.
  Widget settingsIcon() {
    return showSettings
        ? GestureDetector(
            onTap: onSettingsPressed,
            child: Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset("assets/svg/settings.svg")),
          )
        : const Padding(padding: EdgeInsets.zero);
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 90);
}
