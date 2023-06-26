import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// The [SettingsBar] class custom widget that displays a settings bar with a back button, a title, and an icon.
class SettingsBar extends StatelessWidget {
  /// A callback function that is called when the back button is tapped.
  final VoidCallback onTap;

  /// The icon to display in the settings bar.
  final IconData icon;

  /// The title to display in the settings bar.
  final String titleLabel;

  /// Constructs a new instance of the [SettingsBar] class with the specified parameters.
  ///
  /// The [onTap], [icon], and [titleLabel] parameters must not be null.
  const SettingsBar(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.titleLabel});

  /// Builds the `SettingsBar` widget.
  ///
  /// This method returns a `Padding` widget that contains a `SizedBox` widget with
  /// a specified width and a `Row` widget with a back button, a title, and an icon.
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  splashColor: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorConstants.appColor,
                    size: 24,
                  ),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 88,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        titleLabel,
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  )),
              Spacer(),
            ],
          ),
        ));
  }
}
