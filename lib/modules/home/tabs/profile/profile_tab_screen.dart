import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/home/tabs/tabs.dart';
import 'package:hundopt/shared/shared.dart';

/// The [ProfileTab] class representing the screen with user data and user reserved dogs
class ProfileTab extends GetView<ProfileController> {
  /// Constructs a new instance of the [ProfileTab] class.
  ///
  /// The [key] parameter is optional and is used to specify a key for the widget.
  const ProfileTab({super.key});

  /// Builds the widget tree for the favourite screen.
  ///
  /// This method returns a [ProfileTab] widget containing a [Scaffold] widget
  /// with a [Container] with all the user data such as username, profile picture and
  /// a [GridView] with all the reserved dogs for the current user
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
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
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
                  Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundImage: controller.user.value.pictureURL != ""
                        ? NetworkImage(controller.user.value.pictureURL)
                        : Image.asset(
                      fit: BoxFit.fill,
                      AssetsPath.defaultProfilePic,
                    ).image,
                  ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsPath.reservedDogPic, height: 45),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      StringConstants.reservedDogsLabel,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ],
              ),
            ),
            const HorizontalBar(isLeft: true),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            Expanded(
              child: Obx(() => SingleChildScrollView(
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      children: List.generate(
                          controller.userAdoptingDogs.length, (index) {
                        return GestureDetector(
                          onTap: () => {
                            controller.navigateToDogInfo(
                                controller.userAdoptingDogs[index]),
                          },
                          child: GridTile(
                            child: Container(
                                margin: const EdgeInsets.all(10),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                          child: AspectRatio(
                                            aspectRatio: 1 / 1,
                                            child: Image.network(
                                              controller.userAdoptingDogs[index]
                                                  .mainPictureURL,
                                              fit: BoxFit.cover,
                                              width: 84.0,
                                              height: 84.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        controller.userAdoptingDogs[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        controller
                                            .userAdoptingDogs[index].breed,
                                        style: Styles.bodySmall,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        );
                      }),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
