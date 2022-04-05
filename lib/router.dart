import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/app_scaffold.dart';
import 'package:wonders/ui/screens/artifact/artifact_details/artifact_details_screen.dart';
import 'package:wonders/ui/screens/artifact/artifact_highlights/artifact_highlights_screen.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_screen.dart';
import 'package:wonders/ui/screens/settings/settings_screen.dart';
import 'package:wonders/ui/screens/splash/splash_screen.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/video_player/video_playback_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonders_details_screen.dart';

class ScreenPaths {
  static String splash = '/';
  static String home = '/home';
  static String settings = '/settings';
  static String wonderDetails(WonderType type) => '/wonder/${type.name}';
  static String timeline(WonderType type) => '/timeline/${type.name}';
  static String video(String id) => '/video/$id';
  static String highlights(WonderType type) => '/highlights/${type.name}';
  static String search(WonderType type) => '/search/${type.name}';
  static String artifact(String id, WonderType type) => '/artifact/${type.name}/$id';
}

String? _handleRedirect(GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!app.isBootstrapComplete && state.location != ScreenPaths.splash) {
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
    // '/'
    AppRoute(ScreenPaths.splash, (_) => SplashScreen()),
    AppRoute(ScreenPaths.home, (_) => WondersHomeScreen()),
    AppRoute(ScreenPaths.settings, (_) => SettingsScreen()),
    AppRoute('/wonder/:id', (s) {
      return WonderDetailsScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/timeline/:id', (s) {
      return TimelineScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/video/:id', (s) {
      return FullscreenVideoPage(id: s.params['id']!);
    }),
    AppRoute('/highlights/:id', (s) {
      return ArtifactHighlightsScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/search/:id', (s) {
      return ArtifactSearchScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/artifact/:type/:id', (s) {
      return ArtifactDetailsScreen(id: s.params['id']!, type: _parseWonderType(s.params['type']!));
    })
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder, {List<GoRoute> routes = const []})
      : super(
          path: path,
          routes: routes,
          builder: (_, state) => builder(state),
        );
}
