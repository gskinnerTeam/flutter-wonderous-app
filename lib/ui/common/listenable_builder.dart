import 'package:flutter/cupertino.dart';

/// Replacement for the built in [AnimatedBuilder] because that name is semantically confusing.
class ListenableBuilder extends AnimatedBuilder {
  const ListenableBuilder({
    super.key,
    required Listenable listenable,
    required super.builder,
    super.child,
  }) : super(animation: listenable);
}
