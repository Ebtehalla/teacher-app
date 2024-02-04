import 'dart:ui';

import 'package:get/get.dart';
import 'package:halo_teacher/app/translation/fr.dart';

import '../translation/sa_SA.dart';

class LocalizationService extends Translations {
  static final locale = Locale('sa', "SA");

  static final langs = ['English', "Urdu", 'France', 'Saudi Arabia'];

  static final locales = [
    Locale('en', 'US'),
    Locale('ur', 'PK'),
    Locale('sa', 'SA'),
    Locale('fr', null)
  ];
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'sa_SA': sa,
        'fr': fr,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    int index = langs.indexOf(lang);
    return locales[index];
  }
}
