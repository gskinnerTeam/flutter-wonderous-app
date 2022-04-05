import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/search_controller.dart';
import 'package:wonders/logic/search_service.dart';
import 'package:wonders/logic/unsplash_controller.dart';
import 'package:wonders/logic/unsplash_service.dart';
import 'package:wonders/logic/wonders_controller.dart';

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
  GetIt.I.registerLazySingleton<AppController>(() => AppController());
  // Search
  GetIt.I.registerLazySingleton<SearchController>(() => SearchController());
  GetIt.I.registerLazySingleton<SearchService>(() => SearchService());
  // Settings
  GetIt.I.registerLazySingleton<SettingsController>(() => SettingsController());
  // Unsplash
  GetIt.I.registerLazySingleton<UnsplashController>(() => UnsplashController());
  GetIt.I.registerLazySingleton<UnsplashService>(() => UnsplashService());
  // Wonders
  GetIt.I.registerLazySingleton<WondersController>(() => WondersController());
  // Testing mocks
  if (useMocks) {
    //GetIt.I.pushNewScope();
  }
}

/// Add syntax sugar for quickly accessing the main controllers in the app
/// We deliberately do not create shortcuts for services, to discourage their use directly in the ui layer.
AppController get app => GetIt.I.get<AppController>();
SearchController get search => GetIt.I.get<SearchController>();
SettingsController get settings => GetIt.I.get<SettingsController>();
UnsplashController get unsplash => GetIt.I.get<UnsplashController>();
WondersController get wonders => GetIt.I.get<WondersController>();
