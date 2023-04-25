import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/widgets.dart';
import 'auth_controller.dart';

class ForgotPassword extends StatelessWidget {
  final AuthController controller = Get.arguments;

  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: ColorConstants.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringConstants.recuperarPwd,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    child: Text(
                      StringConstants.infoRecuperarPwd,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const CustomTextField(labelText: StringConstants.email),
                  SizedBox(
                      // TODO: Change onerror for the form
                      child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: 50,
                    color: Colors.red,
                    child: Text("a"),
                  )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.24)),
                  AppPrimaryButton(
                      text: StringConstants.enviarEmail,
                      onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                      backgroundColor:
                                          ColorConstants.background,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  color:
                                                      ColorConstants.appColor,
                                                  size: 24,
                                                ),
                                                onPressed: () => Get.back(),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      20, 0, 20, 0),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [

                                                    Text(
                                                      StringConstants
                                                          .correoEnviado,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Padding(
                                                        padding:
                                                        EdgeInsets.all(10)),
                                                    Text(
                                                      StringConstants
                                                          .resetPwdMsg,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(10)),
                                                    AppPrimaryButton(
                                                        text: StringConstants
                                                            .continuar,
                                                        onPressed: () =>
                                                            Get.back()),
                                                        ClickableText(uText: StringConstants.cancel, text: "", onPressed: () =>
                                                            Get.back())// TODO: MAke widget of this dialog, change the alignment of the clickabletext and change this onpressed
                                                  ]),

                                                  //margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ]);
                                }) // TODO: Change the route
                          }),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.02)),
                  ClickableText(
                      uText: StringConstants.atras,
                      text: StringConstants.noRecuperarPwd,
                      onPressed: () => {
                            Get.toNamed(Routes.AUTH + Routes.LOGIN,
                                arguments: controller)
                          }), // TODO: Add onpressed
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
