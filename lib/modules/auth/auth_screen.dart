import 'package:flutter/material.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/widgets.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      color: ColorConstants.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height * 0.1, 0, 0)),
          Image.asset(
            AssetsPath.appLogo,
            fit: BoxFit.contain,
            height: 300,
          ),
          Text(
            StringConstants.appName,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05),
            child: Text(
              StringConstants.authMsg,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          AppPrimaryButton(
              text: StringConstants.crearCuenta, onPressed: () => {}),
          // TODO: ADD ONPRESSED
          const ButtonPadding(),
          AppSecondaryButton(
              text: StringConstants.iniciarSession, onPressed: () => {})
          // TODO: ADD ONPRESSED
        ],
      ),
    );
  }
}
