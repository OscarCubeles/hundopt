import 'package:get/get_rx/src/rx_types/rx_types.dart';

/// The [Validations] class provides utility methods for validating user input.
class Validations {
  /// Returns `true` if the given [val] is a valid email address.
  ///
  /// The [val] parameter is checked against a regular expression that matches email addresses.
  /// If the [val] is not a valid email address, the [errText] parameter is set to an error message and the method returns false.
  static bool isValidEmail(String val, RxnString errText) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val)) {
      errText.value = 'Formato de email no válido.';
      return false;
    }
    return true;
  }

  /// Returns `true` if the given [val] is a valid password.
  ///
  /// The [val] parameter is checked against a regular expression that matches passwords.
  /// If the [val] is not a valid password, the [errText] parameter is set to an error message and the method returns false.
  static bool isValidPassword(String val, RxnString errText) {
    if (!RegExp(r"^(?=.*?[0-9])(?=.*?[^\w\s]).{1,}$").hasMatch(val)) {
      errText.value = 'Al menos un número y un carácter especial.';
      return false;
    }
    return true;
  }

  /// Returns `true` if the given [val] is a valid username.
  ///
  /// The [val] parameter is checked against several conditions to ensure that it is a valid username.
  /// If the [val] is not a valid username, the [errText] parameter is set to an error message and the method returns false.
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

  /// Returns `true` if the length of the given [val] is greater than or equal to [minLen].
  ///
  /// If the length of the [val] is less than [minLen], the [err] parameter is set to an error message and the method returns false.
  static bool lengthOK(String val, RxnString err, {int minLen = 8}) {
    if (val.length < minLen) {
      err.value = 'La longitud mínima es de 8 caracteres';
      return false;
    }
    return true;
  }

  /// Returns `true` if the given [val] has a country code.
  ///
  /// The [val] parameter is checked against a regular expression that matches phone numbers with country codes.
  /// If the [val] does not have a country code, the [errText] parameter is set to an error message and the method returns false.
  bool hasCountryCode(String val, RxnString errText) {
    if (!RegExp(r'^\+\d{1,3}(?:\(\d{1,4}\))?(?:\s|)?').hasMatch(val)) {
      errText.value = 'Añade el código de país.';
      return false;
    }
    return true;
  }

  /// Returns `true` if the given [val] is a valid phone number.
  ///
  /// The [val] parameter is checked against a regular expression that matches phone numbers.
  /// If the [val] is not a valid phone number, the [errText] parameter is set to an error message and the method returns false.
  bool isValidNumber(String val, RxnString errText) {
    if (!RegExp(r'^\+(?:[0-9]●?){6,14}[0-9]$').hasMatch(val)) {
      errText.value = 'Número de digitos incorrecto. No añada espacios.';
      return false;
    }
    return true;
  }
}
