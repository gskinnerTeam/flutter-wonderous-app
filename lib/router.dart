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
import 'package:wonders/ui/screens/intro/intro_screen.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/wallpaper_photo/wallpaper_photo_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonders_details_screen.dart';

/// Shared paths / urls used across the app
class ScreenPaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';
  static String settings = '/settings';
  static String wonderDetails(WonderType type, {int tabIndex = 0}) => '/wonder/${type.name}?t=$tabIndex';
  static String video(String id) => '/video/$id';
  static String highlights(WonderType type) => '/highlights/${type.name}';
  static String search(WonderType type) => '/search/${type.name}';
  static String artifact(String id) => '/artifact/$id';
  static String collection(String id) => '/collection?id=$id';
  static String maps(WonderType type) => '/maps/${type.name}';
  static String timeline(WonderType? type) => '/timeline?type=${type?.name ?? ''}';
  static String wallpaperPhoto(WonderType type) => '/wallpaperPhoto/${type.name}';
}

/// Routing table, matches string paths to UI Screens
final appRouter = GoRouter(
  redirect: _handleRedirect,
  navigatorBuilder: (_, __, child) => WondersAppScaffold(child: child),
  routes: [
    AppRoute(ScreenPaths.splash, (_) => Container(color: $styles.colors.greyStrong)), // This will be hidden
    AppRoute(ScreenPaths.home, (_) => HomeScreen()),
    AppRoute(ScreenPaths.intro, (_) => IntroScreen()),
    AppRoute('/wonder/:type', (s) {
      int tab = int.tryParse(s.queryParams['t'] ?? '') ?? 0;
      return WonderDetailsScreen(
        type: _parseWonderType(s.params['type']!),
        initialTabIndex: tab,
      );
    }, useFade: true),
    AppRoute('/timeline', (s) {
      return TimelineScreen(type: _tryParseWonderType(s.queryParams['type']!));
    }),
    AppRoute('/video/:id', (s) {
      return FullscreenVideoPage(id: s.params['id']!);
    }),
    AppRoute('/highlights/:type', (s) {
      return ArtifactCarouselScreen(type: _parseWonderType(s.params['type']!));
    }),
    AppRoute('/search/:type', (s) {
      return ArtifactSearchScreen(type: _parseWonderType(s.params['type']!));
    }),
    AppRoute('/artifact/:id', (s) {
      return ArtifactDetailsScreen(artifactId: s.params['id']!);
    }),
    AppRoute('/collection', (s) {
      return CollectionScreen(fromId: s.queryParams['id'] ?? '');
    }),
    AppRoute('/maps/:type', (s) {
      return FullscreenMapsViewer(type: _parseWonderType(s.params['type']!));
    }),
    AppRoute('/wallpaperPhoto/:type', (s) {
      return WallpaperPhotoScreen(type: _parseWonderType(s.params['type']!));
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
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

String? _handleRedirect(GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to: ${state.location}');
  return null; // do nothing
}

WonderType _parseWonderType(String value) => _tryParseWonderType(value) ?? WonderType.chichenItza;

WonderType? _tryParseWonderType(String value) => WonderType.values.asNameMap()[value];
