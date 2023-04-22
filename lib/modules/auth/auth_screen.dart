import 'package:flutter/material.dart';
import '../../shared/constants/constants.dart';

class AuthScreen extends StatelessWidget {


  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      color: ColorConstants.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.1, 0, 0)),
          Image.asset('assets/images/logo.png',
            fit: BoxFit.contain,
            height: 300,
          ),
          Text(StringConstants.appName,
            style: Styles.title,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
            child: Text(StringConstants.authMsg,
              style: Styles.text18,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color(0xff34D499))),
                onPressed: () {

                },
                child: Text("Login",
                    style: Styles.text18
          ),
    ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
                onPressed: () {
                },
                style: TextButton.styleFrom(
                  side: BorderSide(
                      width: 3.0, color: Color(0xff34D499)),
                ),
                child: Text(
                  "Sign Up",
                  style: Styles.text18,
                )),
          )
        ],
      ),
    );
  }
}
