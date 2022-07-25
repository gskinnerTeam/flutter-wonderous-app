import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl_standalone.dart';
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

//Widget for wrapping main app and call LocalizationHelper.load() after findSystemLocale() call
class LocalizationBuilder extends StatelessWidget {
  const LocalizationBuilder({Key? key, required this.builder}) : super(key: key);

  final Widget Function(Locale locale) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: findSystemLocale(),
      builder: (_, localeSnapshot) {
        if (localeSnapshot.hasData) {
          final locale = Locale(localeSnapshot.data!.split('_')[0]);
          // final locale = Locale('zh');

          return FutureBuilder(
            future: LocalizationHelper.load(locale),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return builder(locale);
              }
              return CircularProgressIndicator();
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
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
