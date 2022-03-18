import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const double kDefaultDuration = .3;

  static Route<T> fadeThrough<T>(Widget child, [double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(animation: animation, secondaryAnimation: secondaryAnimation, child: child);
      },
    );
  }

  static Route<T> fadeScale<T>(Widget child, [double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static Route<T> sharedAxis<T>(Widget child,
      [SharedAxisTransitionType type = SharedAxisTransitionType.scaled, double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
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
