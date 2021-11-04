import 'dart:async';
import 'dart:ui';

import 'package:localization/localization.dart';

class LocalizationHelper {
  Future<void> configuration(List<String> paths) async {
    Localization.setTranslationDirectories(paths);

    var language = window.locale.toString();
    language = (language.toLowerCase().startsWith('es_')) ? 'es_ES' : language;

    await Localization.configuration(selectedLanguage: language);
  }
}
