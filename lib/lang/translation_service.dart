import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'es_ES.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('es', 'ES');
  @override
  Map<String, Map<String, String>> get keys => {
        'es_ES': es_ES,
      };
}
