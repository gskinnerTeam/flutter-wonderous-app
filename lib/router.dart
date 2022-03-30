import 'package:wonders/common_libs.dart';
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
    AppRoute('/search/:id', (s) {
      return SearchScreen(type: _parseWonderType(s.params['id']!));
    }),
    AppRoute('/artifact/:id', (s) {
      return ArtifactScreen(id: s.params['id']!);
    })
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder, {List<GoRoute> routes = const []})
      : super(
            path: path,
            routes: routes,
            pageBuilder: (_, s) {
              return FadingPage(builder(s), key: s.pageKey);
            });
}

/// Custom page transition
class FadingPage extends Page {
  const FadingPage(this.child, {LocalKey? key}) : super(key: key);
  final Widget child;

  @override
  Route createRoute(BuildContext context) {
    final tweenIn = Tween<double>(begin: 0, end: 1);
    final tweenOut = Tween<double>(begin: 1, end: 0);
    return PageRouteBuilder(
      settings: this,
      transitionsBuilder: (_, anim1, anim2, child) {
        return FadeTransition(
          opacity: tweenIn.animate(anim1),
          child: FadeTransition(
            opacity: tweenOut.animate(anim2),
            child: child,
          ),
        );
      },
      pageBuilder: (_, __, ___) => Scaffold(body: child),
    );
  }
}
