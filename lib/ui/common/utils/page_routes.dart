import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const Duration kDefaultDuration = Duration(milliseconds: 300);

  static Route<T> dialog<T>(Widget child, [Duration duration = kDefaultDuration, bool opaque = false]) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      opaque: opaque,
      fullscreenDialog: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  static Route<T> fadeThrough<T>(Widget child, [Duration duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(animation: animation, secondaryAnimation: secondaryAnimation, child: child);
      },
    );
  }

  static Route<T> fadeScale<T>(Widget child, [Duration duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static Route<T> sharedAxis<T>(Widget child,
      [SharedAxisTransitionType type = SharedAxisTransitionType.scaled, Duration duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
        );
      },
    );
  }
}
