import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/routing/app_route.dart';
import 'package:wonders/ui/app_scaffold.dart';
import 'package:wonders/ui/screens/artifact/artifact_screen.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';
import 'package:wonders/ui/screens/search/search_screen.dart';
import 'package:wonders/ui/screens/settings/settings_screen.dart';
import 'package:wonders/ui/screens/splash_screen.dart';
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
  static String artifact(String id) => '/artifact/$id';
  static String search(WonderType type) => '/search/${type.name}';
}

WonderType _parseWonderType(String value) => WonderType.values.asNameMap()[value] ?? WonderType.machuPicchu;

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
    AppRoute('/search/:id', (s) {
      return SearchScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/artifact/:id', (s) {
      return ArtifactScreen(id: s.params['id']!);
    })
  ],
);

String? _handleRedirect(GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!app.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to: ${state.location}');
  return null; // do nothing
}
