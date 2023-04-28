import 'package:flutter/cupertino.dart';
import 'package:hundopt/shared/shared.dart';

class PersonalityFormScreen extends StatelessWidget {
  const PersonalityFormScreen({super.key});

  @override
  Widget build(BuildContext context) {

        return Container(
          color: ColorConstants.background,
          child: SafeArea(
            child: AppScaffold(child: Text("Form"), showAppBar: false),
          )
        );

  }
}
