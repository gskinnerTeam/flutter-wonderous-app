part of 'fx.dart';

// Applies animated effects to a list of widgets. It does this by wrapping each
// widget in FXAnimate, and then proxying addFX calls to all instances. It can
// also offset the timing of each widget's animation via `interval`.
//
// For example, this would fade and scale every item in the Column, offsetting
// the start of each by 100 milliseconds:
//
//    Column(children: [foo, bar, baz].fx(interval: 100.ms).fade().scale())
//
// Like FXAnimate, it can also be used declaratively. The following is
// equivalent to the above example.
//
//    Column(
//      children: FXAnimateList(
//        fx: [Fade(), Scale()],
//        children:[foo, bar, baz],
//      )
//    )
class FXAnimateList<T extends Widget> extends ListBase<Widget>
    with FXManager<FXAnimateList> {
  static Duration defaultInterval = const Duration(milliseconds: 200);
  // Types to completely ignore in a list.
  static Set<Type> ignoreTypes = {Spacer};

  // Types to reparent, mapped to a method that handles that type.
  static Map reparentTypes = <Type, Widget Function(Widget, Widget)>{
    Flexible: (parent, child) {
      Flexible o = parent as Flexible;
      return Flexible(key: o.key, flex: o.flex, fit: o.fit, child: child);
    },
    Positioned: (parent, child) {
      Positioned o = parent as Positioned;
      return Positioned(
          key: o.key,
          left: o.left,
          top: o.top,
          right: o.right,
          bottom: o.bottom,
          width: o.width,
          height: o.height,
          child: child);
    },
    Expanded: (parent, child) {
      Expanded o = parent as Expanded;
      return Expanded(key: o.key, flex: o.flex, child: child);
    }
  };

  final List<Widget> widgets = [];
  final List<FXAnimate> managers = [];

  FXAnimateList({required List<Widget> children, List<AbstractFX>? fx}) {
    // build new list, wrapping items in FXCore
    for (Widget child in children) {
      Type type = child.runtimeType;
      if (!ignoreTypes.contains(type)) {
        Function? f = reparentTypes[type];
        final FXAnimate manager;
        if (f != null) {
          manager = FXAnimate(
            child: (child as dynamic).child,
          );
          child = f(child, manager);
        } else {
          manager = child = FXAnimate(child: child);
        }
        managers.add(manager);
      }
      widgets.add(child);
      if (fx != null) {
        addFXList(fx);
      }
    }
  }

  @override
  FXAnimateList addFX(AbstractFX fx) {
    for (FXAnimate manager in managers) {
      manager.addFX(fx);
    }
    return this;
  }

  @override
  FXAnimateList addFXList(List<AbstractFX> fx) {
    for (FXAnimate manager in managers) {
      manager.addFXList(fx);
    }
    return this;
  }

  FXAnimateList call(
      {Duration? interval, Function()? onComplete, List<AbstractFX>? fx}) {
    if (managers.isEmpty || managers.first._fx.isNotEmpty) {
      // throw error?
      return this;
    }
    if (interval != null) {
      int i = 0;
      for (FXAnimate core in managers) {
        core._offset = (interval * ++i);
      }
    }
    if (onComplete != null) {
      // strip the controller:
      managers.last(onComplete: (_) => onComplete());
    }
    if (fx != null) {
      addFXList(fx);
    }
    return this;
  }

  // concrete implementations required when extending ListBase:
  @override
  set length(int length) {
    widgets.length = length;
  }

  @override
  int get length => widgets.length;
  @override
  Widget operator [](int index) => widgets[index];
  @override
  void operator []=(int index, Widget value) {
    widgets[index] = value;
  }
}

extension FXListExtensions on List<Widget> {
  FXAnimateList get fx => FXAnimateList(children: this);
}
