import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/modules.dart';
import 'package:hundopt/shared/widgets/text_field.dart';

import '../constants/string_constants.dart';

class FormSelectorQuestion extends StatelessWidget {
  //final FormController controller = Get.find();
  final String text;
  const FormSelectorQuestion({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        TextField(
          onChanged: (value) => {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => {},
              child: Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Next'),
            )]),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView.builder(
                  itemCount: 10, // number of items in the list
                  itemBuilder: (context, index) {
                    // create a widget for each item in the list
                    return CheckboxListTile(
                      selected: true, value: false, onChanged: (bool? value) {  },

                    );
                  },
            ))
          ],
        ),
    );
  }
}

class FormWrittenQuestion extends StatelessWidget{
  const FormWrittenQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          StringConstants.helloText,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          StringConstants.helloFormText,
          style: Theme.of(context).textTheme.bodySmall
        ),
        CustomTextField(labelText: StringConstants.nameAndSurnameLabel, errorText: 'not long enough', onChanged: (String value) {  }, isPassword: false,

        )
      ],
    );
  }
  void lEmailChanged(String val) {
    print(val);
  }

}
