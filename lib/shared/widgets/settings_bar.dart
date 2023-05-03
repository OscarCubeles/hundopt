import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SettingsBar extends StatelessWidget{
  const SettingsBar({super.key, required this.onTap, required this.icon, required this.titleLabel});

  final VoidCallback onTap;
  final IconData icon;
  final String titleLabel;


  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
              Container(
                  width: MediaQuery.of(context).size.width - 88,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        titleLabel,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall,
                      )
                    ],
                  )),
              Spacer(),
            ],
          ),
        ));
  }

}