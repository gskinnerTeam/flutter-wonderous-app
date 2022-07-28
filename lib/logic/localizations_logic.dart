import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:intl/intl_standalone.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationsLogic {
  AppLocalizations? _instance;
  AppLocalizations get instance => _instance!;

  bool get isLoaded => _instance != null;

  Future<void> load() async {
    final localeCode = await findSystemLocale();
    Locale locale = Locale(localeCode.split('_')[0]);
    if (kDebugMode) {
      locale = Locale('zh');
    }
    _instance = await AppLocalizations.delegate.load(locale);
  }
}