import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:intl/intl_standalone.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleLogic {
  AppLocalizations? _strings;
  AppLocalizations get strings => _strings!;

  bool get isLoaded => _strings != null;

  Future<void> load() async {
    final localeCode = await findSystemLocale();
    Locale locale = Locale(localeCode.split('_')[0]);
    if (kDebugMode) {
      // Uncomment for testing in chinese
      // locale = Locale('zh');
    }
    _strings = await AppLocalizations.delegate.load(locale);
  }
}
