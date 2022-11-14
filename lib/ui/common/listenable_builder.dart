import 'package:flutter/cupertino.dart';

class ListenableBuilder extends AnimatedBuilder {
  const ListenableBuilder({
    Key? key,
    required Listenable listenable,
    required TransitionBuilder builder,
    Widget? child,
  }) : super(key: key, animation: listenable, builder: builder, child: child);
}
