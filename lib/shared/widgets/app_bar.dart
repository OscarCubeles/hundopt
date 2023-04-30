import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/assets_path.dart';
import '../constants/string_constants.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                    AssetsPath.appLogo,
                    fit: BoxFit.contain,
                    height: 45
                ),
                const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                Text(
                  StringConstants.appName,
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 90);
}
