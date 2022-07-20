import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wonders/common_libs.dart';

//LocalizationHelper exists to work around need for BuildContext ( used with AppLocalizations.of(BuildContext context) )
class LocalizationHelper {
  static late AppLocalizations? _instance;
  static AppLocalizations get instance {
    if (_instance == null) {
      throw FlutterError(
          'Call LocalizationHelper.load(Locale locale) before attempting to get instance of AppLocalizations');
    }
    return _instance!;
  }

  static Future<AppLocalizations> load(Locale locale) async {
    _instance = await AppLocalizations.delegate.load(locale);
    return _instance!;
  }
}

extension LocalizationExtensions on String {
  String supplant(Map<String, String> supplants) {
    return replaceAllMapped(RegExp(r'\{\w+\}'), (match) {
      final placeholder = match.group(0) ?? '';
      if (supplants.containsKey(placeholder)) {
        return supplants[placeholder]!;
      }
      return placeholder;
    });
  }
}
