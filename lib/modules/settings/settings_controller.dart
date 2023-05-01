import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/setting_option.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/constants.dart';
import '../../shared/widgets/dialogs.dart';

class SettingsController extends GetxController{

  List<SettingOption> settingOptions = [
  ];

  @override
  void onInit() {
  // TODO : Put these as string constants
    settingOptions = [
      SettingOption(text: "Editar Perfil", iconSource: CupertinoIcons.chevron_right, onPressed: toEditProfile),
      SettingOption(text: "Cambiar Contraseña", iconSource: CupertinoIcons.chevron_right, onPressed: showChangePasswordDialog),
      SettingOption(text: "Rellenar Cuestionario Pre-Adopción", iconSource: CupertinoIcons.doc_plaintext, onPressed: toPersonalityForm),
      SettingOption(text: "Pasos Para Adoptar", iconSource: CupertinoIcons.info, onPressed: showAdoptSteps),
      SettingOption(text: "Cerrar Sesión", iconSource: CupertinoIcons.power, onPressed: showCloseSessionDialog),
      SettingOption(text: "Eliminar Cuenta", iconSource: CupertinoIcons.trash, onPressed: showDeleteAccountDialog)
    ];
  }

  void navigateToHome(){
    Get.back();
  }

  void toPersonalityForm(){
    Get.toNamed(Routes.PERSONALITY_FORM);
  }

  // TODO: Change ontap methods and color of the button
  void showDeleteAccountDialog(){
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleDeleteAccountText,
            text: StringConstants.bodyDeleteAccountText,
            buttonText: StringConstants.deleteAccountLabel,
            underlinedText: StringConstants.cancelLabel,
            buttonColor: ColorConstants.warningRed,
            onPressed: () => navigateToHome(),
            onClose: () => Get.back(),
          );
        });
  }

  // TODO: add methods
  void showCloseSessionDialog(){
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleCloseSessionText,
            text: StringConstants.bodyCloseSessionText,
            buttonText: StringConstants.closeSessionLabel,
            underlinedText: StringConstants.cancelLabel,
            buttonColor: ColorConstants.appColor,
            onPressed: () => navigateToHome(),
            onClose: () => Get.back(),
          );
        });
  }

  void showChangePasswordDialog(){
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleChangePwdText,
            text: StringConstants.bodyChangePwdText,
            buttonText: StringConstants.changePwdLabel,
            underlinedText: StringConstants.cancelLabel,
            buttonColor: ColorConstants.appColor,
            onPressed: () => navigateToHome(),
            onClose: () => Get.back(),
          );
        });
  }

  void toEditProfile(){

  }

  void showAdoptSteps(){

  }

  void showExitDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NotificationDialog(
            title: StringConstants.titleFormExitText,
            text: StringConstants.bodyFormExitText,
            buttonText: StringConstants.exitFormLabel,
            underlinedText: "",
            buttonColor: ColorConstants.appColor,
            onPressed: () => navigateToHome(),
            onClose: () => Get.back(),
          );
        });
  }

}