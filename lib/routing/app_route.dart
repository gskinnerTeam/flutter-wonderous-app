import 'package:wonders/common_libs.dart';

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
