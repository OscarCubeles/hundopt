
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Validations{
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

  static bool lengthOK(String val, RxnString err, {int minLen = 8}) {
    if (val.length < minLen) {
      err.value = 'La longitud mínima es de 8 caracteres';
      return false;
    }
    return true;
  }
}