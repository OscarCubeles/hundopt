import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../models/dog.dart';

class ExploreController extends GetxController{
  final Rx<List<Dog>> _dogList = Rx<List<Dog>>([]);
  List<Dog> get dogList => _dogList.value;
  late VideoPlayerController videoController;
  RxBool isLiked = false.obs;

  VideoPlayerController get videoPlayerController1 => videoController;
  late ChewieController _chewieController;


  @override
  void onInit() {
    addDog(Dog(name: "Kira", videoUrl: "assets/videos/pexels-anna-bondarenko-5534310-1080x1920-30fps.mp4", location: "Barcelona"));
    addDog(Dog(name: "Kira", videoUrl: "assets/videos/pexels-anna-bondarenko-5877829-1080x1920-30fps.mp4", location: "Barcelona"));
    addDog(Dog(name: "Kira", videoUrl: "assets/videos/pexels-anna-bondarenko-5877829-1080x1920-30fps.mp4", location: "Barcelona"));
    videoController =
        VideoPlayerController.network(
          'https://lifetime-app.be/wp-content/uploads/2020/08/IMG_5648-1.mp4',
        );
  }

  void likeDog(){
    isLiked.value = !isLiked.value;
    print("liked");
  }

  void addDog(Dog dog) {
    dogList.add(dog);
  }

  onPageChanged(int index) {
    print("page changed");
  }


}