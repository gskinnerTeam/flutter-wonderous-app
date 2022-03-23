import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/main.dart';
import 'package:wonders/ui/app_scaffold.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';
import 'package:wonders/ui/screens/search/search_screen.dart';
import 'package:wonders/ui/screens/splash_screen.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonders_details_screen.dart';

class ScreenPaths {
  static String splash = '/';
  static String home = '/home';
  static String wonderDetails(WonderType type) => '/wonder/${type.name}';
  static String wonderGallery(WonderType type) => '/gallery/${type.name}';
  static String timeline(WonderType type) => '/timeline/${type.name}';
  static String search(WonderType type) => '/search/${type.name}';
}

WonderType parseWonderType(String value) => WonderType.values.asNameMap()[value] ?? WonderType.machuPicchu;

final appRouter = GoRouter(
  redirect: _handleRedirect,
  navigatorBuilder: (_, __, child) => WondersAppScaffold(child: child),
  routes: [
    // '/'
    AppRoute(ScreenPaths.splash, (_) => SplashScreen()),
    AppRoute(ScreenPaths.home, (_) => WondersHomeScreen()),
    AppRoute('/wonder/:id', (s) {
      return WonderDetailsScreen(type: parseWonderType(s.params['id']!));
    }),
    AppRoute('/timeline/:id', (s) {
      return TimelineScreen(type: parseWonderType(s.params['id']!));
    }),
    AppRoute('/search/:id', (s) {
      return SearchScreen(type: parseWonderType(s.params['id']!));
    })
  ],
);

String? _handleRedirect(state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!app.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  return null; // do nothing
}

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder, {List<GoRoute> routes = const []})
      : super(path: path, routes: routes, pageBuilder: (_, s) => FadingPage(builder(s), key: s.pageKey));
}

/// Custom page transition
class FadingPage extends Page {
  const FadingPage(this.child, {LocalKey? key}) : super(key: key);
  final Widget child;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionsBuilder: (_, anim1, anim2, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(anim1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 1, end: 0).animate(anim2),
            child: child,
          ),
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Scaffold(body: child);
      },
    );
  }
}
