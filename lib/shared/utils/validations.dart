import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Validations {
  static bool isValidEmail(String val, RxnString errText) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val)) {
      errText.value = 'Formato de email no válido.';
      return false;
    }
    return true;
  }

  static bool isValidPassword(String val, RxnString errText) {
    if (!RegExp(r"^(?=.*?[0-9])(?=.*?[^\w\s]).{1,}$").hasMatch(val)) {
      errText.value = 'Al menos un número y un carácter especial.';
      return false;
    }
    return true;
  }

  static bool isValidUsername(String val, RxnString errText) {
    if (val.contains(' ')) {
      errText.value = 'El nombre de usuario no puede tener espacios.';
      return false;
    }
    if (RegExp(r'[^\w\s]').hasMatch(val)) {
      errText.value =
          'El nombre de usuario no puede tener caracteres especiales.';
      return false;
    }
    if (val.startsWith(RegExp(r'[0-9]'))) {
      errText.value = 'El nombre de usuario no puede comenzar con números.';
      return false;
    }
    return true;
  }

  static bool lengthOK(String val, RxnString err, {int minLen = 8}) {
    if (val.length < minLen) {
      err.value = 'La longitud mínima es de 8 caracteres';
      return false;
    }
    return true;
  }

  bool hasCountryCode(String val, RxnString errText) {
    if (!RegExp(r'^\+\d{1,3}(?:\(\d{1,4}\))?(?:\s|)?').hasMatch(val)) {
      errText.value = 'Añade el código de país.';
      return false;
    }
    return true;
  }

  bool isValidNumber(String val, RxnString errText) {
    if (!RegExp(r'^\+(?:[0-9]●?){6,14}[0-9]$').hasMatch(val)) {
      errText.value = 'Número de digitos incorrecto. No añada espacios.';
      return false;
    }
    return true;
  }
}
