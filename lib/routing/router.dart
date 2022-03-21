import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/routing/app_route.dart';
import 'package:wonders/ui/app_scaffold.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';
import 'package:wonders/ui/screens/splash_screen.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/video_player/video_playback_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonders_details_screen.dart';

class ScreenPaths {
  static String splash = '/';
  static String home = '/home';
  static String wonderDetails(WonderType type) => '/wonder/${type.name}';
  static String wonderGallery(WonderType type) => '/gallery/${type.name}';
  static String timeline(WonderType type) => '/timeline/${type.name}';
  static String video(String id) => '/video/$id';
}

WonderType _parseWonderType(String value) => WonderType.values.asNameMap()[value] ?? WonderType.machuPicchu;

final appRouter = GoRouter(
  redirect: _handleRedirect,
  navigatorBuilder: (_, __, child) => WondersAppScaffold(child: child),
  routes: [
    // '/'
    AppRoute(ScreenPaths.splash, (_) => SplashScreen()),
    AppRoute(ScreenPaths.home, (_) => WondersHomeScreen()),
    AppRoute('/wonder/:id', (s) {
      return WonderDetailsScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/timeline/:id', (s) {
      return TimelineScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/video/:id', (s) {
      return FullscreenVideoPage(id: s.params['id']!);
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
