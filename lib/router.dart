import 'package:flutter/cupertino.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/app_scaffold.dart';
import 'package:wonders/ui/common/modals//fullscreen_video_viewer.dart';
import 'package:wonders/ui/common/modals/fullscreen_maps_viewer.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_screen.dart';
import 'package:wonders/ui/screens/artifact/artifact_details/artifact_details_screen.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_screen.dart';
import 'package:wonders/ui/screens/collection/collection_screen.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';
import 'package:wonders/ui/screens/settings/settings_screen.dart';
import 'package:wonders/ui/screens/splash/splash_screen.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/wallpaper_photo/wallpaper_photo_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonders_details_screen.dart';

class ScreenPaths {
  static String splash = '/';
  static String home = '/home';
  static String settings = '/settings';
  static String wonderDetails(WonderType type) => '/wonder/${type.name}';
  static String video(String id) => '/video/$id';
  static String highlights(WonderType type) => '/highlights/${type.name}';
  static String search(WonderType type) => '/search/${type.name}';
  static String artifact(String id) => '/artifact/$id';
  static String collection(String id) => '/collection?id=$id';
  static String maps(WonderType type) => '/maps/${type.name}';
  static String timeline(WonderType type) => '/timeline/${type.name}';
  static String wallpaperPhoto(WonderType type) => '/wallpaperPhoto/${type.name}';
}

String? _handleRedirect(GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to: ${state.location}');
  return null; // do nothing
}

WonderType _parseWonderType(String value) => WonderType.values.asNameMap()[value] ?? WonderType.chichenItza;

final appRouter = GoRouter(
  redirect: _handleRedirect,
  navigatorBuilder: (_, __, child) => WondersAppScaffold(child: child),
  routes: [
    AppRoute(ScreenPaths.splash, (_) => SplashScreen()),
    AppRoute(ScreenPaths.home, (_) => WondersHomeScreen()),
    AppRoute(ScreenPaths.settings, (_) => SettingsScreen()),
    AppRoute('/wonder/:id', (s) {
      return WonderDetailsScreen(type: _parseWonderType(s.params['id']!));
    }, useFade: true),
    AppRoute('/timeline/:id', (s) {
      return TimelineScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/video/:id', (s) {
      return FullscreenVideoPage(id: s.params['id']!);
    }),
    AppRoute('/highlights/:id', (s) {
      return ArtifactCarouselScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/search/:id', (s) {
      return ArtifactSearchScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/artifact/:id', (s) {
      return ArtifactDetailsScreen(artifactId: s.params['id']!);
    }),
    AppRoute('/collection', (s) {
      return CollectionScreen(fromId: s.queryParams['id']);
    }),
    AppRoute('/maps/:id', (s) {
      return FullscreenMapsViewer(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/wallpaperPhoto/:id', (s) {
      return WallpaperPhotoScreen(type: _parseWonderType(s.params['id']!));
    }),
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            return buildAppPage(
              context: context,
              state: state,
              useFade: useFade,
              child: Scaffold(
                body: builder(state),
                resizeToAvoidBottomInset: false,
              ),
            );
          },
        );
  final bool useFade;
}

Page<T> buildAppPage<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required bool useFade,
}) {
  if (useFade) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
  return CupertinoPage(child: child);
}
