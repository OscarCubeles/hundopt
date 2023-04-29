import 'package:get/get.dart';

import '../../shared/widgets/widgets.dart';

class FormController extends GetxController {


  RxDouble progress = 0.0.obs;
  var currentIndex = 0.obs;



  final questions = [
    FormWrittenQuestion(),
    FormSelectorQuestion( text: 'Question 2'),
    FormSelectorQuestion( text: 'Question 3'),
    FormSelectorQuestion( text: 'Question 4'),
    FormSelectorQuestion( text: 'Question 5'),
    FormSelectorQuestion( text: 'Question 6'),
    FormSelectorQuestion( text: 'Question 7')
  ];

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
    }
    progress.value = (currentIndex.value+1)/questions.length;
  }

  void previousQuestion(){
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
    progress.value = (currentIndex.value+1)/questions.length;
  }

}

