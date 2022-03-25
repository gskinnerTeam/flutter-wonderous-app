import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/search_controller.dart';
import 'package:wonders/logic/search_service.dart';
import 'package:wonders/logic/unsplash_controller.dart';
import 'package:wonders/logic/unsplash_service.dart';
import 'package:wonders/logic/wonders_controller.dart';
import 'package:wonders/logic/wonders_service.dart';
import 'package:wonders/logic/wonders_service_mock.dart';

void main() {
  registerSingletons(useMocks: true);
  runApp(WondersApp());
  app.bootstrap();
}

class WondersApp extends StatelessWidget {
  const WondersApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser);
}

/// Create singletons (controllers and services) that can be shared across the app.
void registerSingletons({required bool useMocks}) {
  // Top level app controller
  GetIt.I.registerLazySingleton<AppController>(() => AppController());
  // Settings
  GetIt.I.registerLazySingleton<SettingsController>(() => SettingsController());
  // Unsplash
  GetIt.I.registerLazySingleton<UnsplashController>(() => UnsplashController());
  GetIt.I.registerLazySingleton<UnsplashService>(() => UnsplashService());
  // Wonders
  GetIt.I.registerLazySingleton<WondersController>(() => WondersController());
  GetIt.I.registerLazySingleton<WondersService>(() => WondersService());

  GetIt.I.registerLazySingleton<SearchService>(() => SearchService());
  GetIt.I.registerLazySingleton<SearchController>(() => SearchController());

  // Testing mocks

  if (useMocks) {
    GetIt.I.pushNewScope();
    GetIt.I.registerLazySingleton<WondersService>(() => WondersServiceMock());
  }
}

/// Add syntax sugar for quickly accessing the main controllers in the app
/// We deliberately do not create shortcuts for services, to discourage their use directly in the ui layer.
AppController get app => GetIt.I.get<AppController>();
WondersController get wonders => GetIt.I.get<WondersController>();
SettingsController get settings => GetIt.I.get<SettingsController>();
SearchController get search => GetIt.I.get<SearchController>();
UnsplashController get unsplash => GetIt.I.get<UnsplashController>();
