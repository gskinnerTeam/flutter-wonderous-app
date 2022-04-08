import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/search_logic.dart';
import 'package:wonders/logic/search_service.dart';
import 'package:wonders/logic/unsplash_logic.dart';
import 'package:wonders/logic/unsplash_service.dart';
import 'package:wonders/logic/wonders_logic.dart';

void main() {
  registerSingletons(useMocks: true);
  runApp(WondersApp());
  app.bootstrap();
}

class WondersApp extends StatelessWidget {
  const WondersApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser);
  }
}

/// Create singletons (controllers and services) that can be shared across the app.
void registerSingletons({required bool useMocks}) {
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
  // Wonders
  GetIt.I.registerLazySingleton<WondersLogic>(() => WondersLogic());
  // Search
  GetIt.I.registerLazySingleton<SearchLogic>(() => SearchLogic());
  GetIt.I.registerLazySingleton<SearchService>(() => SearchService());
  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  // Unsplash
  GetIt.I.registerLazySingleton<UnsplashLogic>(() => UnsplashLogic());
  GetIt.I.registerLazySingleton<UnsplashService>(() => UnsplashService());
  // Testing mocks
  if (useMocks) {
    //GetIt.I.pushNewScope();
  }
}

/// Add syntax sugar for quickly accessing the main controllers in the app
/// We deliberately do not create shortcuts for services, to discourage their use directly in the ui layer.

AppLogic get app => GetIt.I.get<AppLogic>();
WondersLogic get wonders => GetIt.I.get<WondersLogic>();
SearchLogic get search => GetIt.I.get<SearchLogic>();
SettingsLogic get settings => GetIt.I.get<SettingsLogic>();
UnsplashLogic get unsplash => GetIt.I.get<UnsplashLogic>();
