import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hundopt/modules/tabs/profile/profile_tab_controller.dart';
import 'package:hundopt/shared/constants/colors.dart';
import 'package:hundopt/shared/shared.dart';

import '../../../shared/widgets/app_bar.dart';
import '../../../shared/widgets/app_page.dart';

class ProfileTab extends GetView<ProfileController> {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          showSettings: true, onSettingsPressed: controller.onSettingsPressed),
      body: Container(
        color: ColorConstants.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(controller.username.value,
                          style: Theme.of(context).textTheme.headlineSmall)),
                      Obx(() => Text(
                            controller.fullName.value,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ))
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg'),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/boy.png", height: 45),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Mis Futuros Perros",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ],
              ),
            ),
            HorizontalBar(isLeft: true),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            Expanded(
              child: SingleChildScrollView(
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  children: List.generate(20, (index) {
                    return GridTile(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // set maximum
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: SizedBox.fromSize(
                                    child: AspectRatio(
                                      child: Image.asset(
                                        'assets/images/example_dog.jpg',
                                        fit: BoxFit.cover,
                                        width: 84.0,
                                        height: 84.0,
                                      ),
                                      aspectRatio: 1 / 1,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Text(
                                  "Kira",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              )
                            ],
                          )),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
