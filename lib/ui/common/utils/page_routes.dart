import 'package:flutter/cupertino.dart';

class PageRoutes {
  static const Duration kDefaultDuration = Duration(milliseconds: 300);

  static Route<T> dialog<T>(Widget child, [Duration duration = kDefaultDuration, bool opaque = false]) {
    // Use cupertino routes for all dialogs so we get the 'swipe right to go back' behavior
    return CupertinoPageRoute(builder: (_) => child);

    // SB: Removed this in favor of Cupertino routes, we could restore with a `useFade` option
    // return PageRouteBuilder<T>(
    //   transitionDuration: duration,
    //   reverseTransitionDuration: duration,
    //   pageBuilder: (context, animation, secondaryAnimation) => child,
    //   opaque: opaque,
    //   fullscreenDialog: true,
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) =>
    //       FadeTransition(opacity: animation, child: child),
    // );
  }
}
