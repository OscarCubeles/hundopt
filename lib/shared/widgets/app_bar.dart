import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/assets_path.dart';
import '../constants/string_constants.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showSettings;
  final VoidCallback? onSettingsPressed;

  const MainAppBar(
      {super.key, this.showSettings = false, this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Container(
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
                    Spacer(),
                    settingsIcon()
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget settingsIcon() {
    return showSettings
        ? GestureDetector(
            onTap: onSettingsPressed,
            child: Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset("assets/svg/settings.svg")),
          )
        : Padding(padding: EdgeInsets.zero);
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 90);
}
