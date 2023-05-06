import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/dog_info/dog_info_controller.dart';

class DogInfoScreen extends GetView<DogInfoController> {
  DogInfoScreen({super.key});

  final List<String> images = [
    "assets/images/kira-dog.JPG",
    "assets/images/kira-dog2.JPG",
    "assets/images/kira-dog3.JPG",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,

                child: PageView.builder(
                  itemCount: images.length,
                  onPageChanged: controller.updateIndex,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              images[index],
                            ),
                          ),
                        ),
                      ),
                      /*Container( TODO: Optional container to add color  gradeint on the top of the image
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(.5),
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      )*/
                    ],
                    );
                  },
                ),
              ),
              Positioned(
                top: 40.0,
                left: 10.0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Positioned(
                top: 40.0,
                right: 10.0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.asMap().entries.map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                      const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.imageIndex.value ==
                            entry.key
                            ? Colors.white
                            : Colors.grey,
                      ),
                    );
                  }).toList(),
                )),
              ),
            ]),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dog Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "About Dog",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sodales justo ac arcu hendrerit fringilla. Vivamus euismod rhoncus nisi sit amet eleifend. Proin non dapibus purus. Etiam et est sed libero lobortis bibendum. Duis eget felis odio. Mauris pretium elit vitae velit ultricies elementum. Aenean eu est a libero pharetra fringilla. Aliquam tempus iaculis tellus, in sodales neque malesuada sed.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sodales justo ac arcu hendrerit fringilla. Vivamus euismod rhoncus nisi sit amet eleifend. Proin non dapibus purus. Etiam et est sed libero lobortis bibendum. Duis eget felis odio. Mauris pretium elit vitae velit ultricies elementum. Aenean eu est a libero pharetra fringilla. Aliquam tempus iaculis tellus, in sodales neque malesuada sed.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sodales justo ac arcu hendrerit fringilla. Vivamus euismod rhoncus nisi sit amet eleifend. Proin non dapibus purus. Etiam et est sed libero lobortis bibendum. Duis eget felis odio. Mauris pretium elit vitae velit ultricies elementum. Aenean eu est a libero pharetra fringilla. Aliquam tempus iaculis tellus, in sodales neque malesuada sed.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sodales justo ac arcu hendrerit fringilla. Vivamus euismod rhoncus nisi sit amet eleifend. Proin non dapibus purus. Etiam et est sed libero lobortis bibendum. Duis eget felis odio. Mauris pretium elit vitae velit ultricies elementum. Aenean eu est a libero pharetra fringilla. Aliquam tempus iaculis tellus, in sodales neque malesuada sed.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
