import 'dart:collection';
import 'package:flutter/widgets.dart';

import 'fx.dart';


// FXAnimate makes adding beautiful animated effects (FX) to your widgets
// simple. It supports both a declarative and chained API. The latter is exposed
// via the `Widget.fx` extension, which simply wraps the widget in FXAnimate.
//
//    FXAnimate(child: foo, fx: [FadeFX(), ScaleFX()])
//    foo.fx.fade().scale() // equivalent to above
//
// All effects classes are immutable, and can be shared between FXAnimate
// instances, which lets you create libraries of effects to reuse throughout
// your app.
//
//    FadeFX fadeIn = FadeFX(duration: 100.ms, curve: Curves.easeOut);
//    ScaleFX scaleIn = ScaleFX(begin: 0.8, curve: Curves.easeIn);
//    List<AbstractFX> transitionIn = [fadeIn, scaleIn];
//    // then:
//    FXAnimate(child: foo, fx:transitionIn)
//    foo.fx(fx:transitionIn)
//
// Effects inherit some of their properties (delay, duration, curve) from
// previous effects if unspecified. So in the examples above, the scale will use
// the same duration as the fade that precedes it. All effects also have
// reasonable defaults, so they can be used simply: `foo.fx.fade()`
// ignore: must_be_immutable
class FXAnimate extends StatefulWidget with FXManager<FXAnimate> {
  static Duration defaultDuration = const Duration(milliseconds: 1000);
  static Curve defaultCurve = Curves.linear;

  final Widget child;
  late final List<FXEntry> _fx;
  Duration _offset = Duration.zero;
  Duration _duration = Duration.zero;
  FXEntry? _lastEntry;
  FXAnimateCallback? onComplete;
  FXAnimateCallback? onInit; // todo: FXController

  FXAnimate(
      {Key? key,
      required this.child,
      List<AbstractFX>? fx,
      this.onComplete,
      this.onInit})
      : super(key: key) {
    _fx = [];
    if (fx != null) {
      addFXList(fx);
    }
  }

  FXAnimate call(
      {List<AbstractFX>? fx,
      FXAnimateCallback? onComplete,
      FXAnimateCallback? onInit}) {
    if (_fx.isNotEmpty) {
      // throw error?
      return this;
    }
    this.onComplete = onComplete;
    this.onInit = onInit;
    if (fx != null) {
      addFXList(fx);
    }
    return this;
  }

  Duration get duration => _duration;

  @override
  State<FXAnimate> createState() => _FXAnimateState();

  @override
  FXAnimate addFX(AbstractFX fx) {
    Duration begin =
        _offset + (fx.delay ?? _lastEntry?.fx.delay ?? Duration.zero);
    FXEntry entry = FXEntry(
      fx: fx,
      begin: begin,
      end: begin +
          (fx.duration ?? _lastEntry?.fx.duration ?? FXAnimate.defaultDuration),
      curve: fx.curve ?? _lastEntry?.curve ?? FXAnimate.defaultCurve,
    );
    _fx.add(entry);
    _lastEntry = entry;
    if (entry.end > _duration) {
      _duration = entry.end;
    }
    return this;
  }

  @override
  FXAnimate addFXList(List<AbstractFX> fx) {
    for (AbstractFX o in fx) {
      addFX(o);
    }
    return this;
  }
}

class _FXAnimateState extends State<FXAnimate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    _controller.duration = widget._duration;
    if (widget.onComplete != null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete!(_controller);
        }
      });
    }
    if (widget.onInit != null) {
      widget.onInit!(_controller);
    }
    _controller.forward();
    for (FXEntry entry in widget._fx) {
      child = entry.fx.build(context, child, _controller, entry);
    }
    return child;
  }
}

extension FXWidgetExtensions on Widget {
  FXAnimate get fx => FXAnimate(child: this);
}


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


// Because effects classes (AbstractFX) are immutable and may be reused between 
// multiple FXAnimate instances, an FXEntry is created to store values that may 
// be different between instances. For example, due to `interval` offsets, or
// from inheriting values from prior FX in the chain.
@immutable
class FXEntry {
  final Duration begin;
  final Duration end;
  final Curve curve;
  final AbstractFX fx;

  const FXEntry(
      {required this.fx,
      required this.begin,
      required this.end,
      required this.curve});

  Animation<double> buildAnimation(AnimationController controller,
      {Curve? curve}) {
    return buildSubAnimation(controller, begin, end, curve ?? this.curve);
  }
}


// Builds a sub-animation to the provided controller that runs from start to
// end, with the provided curve. For example, it could create an animation that 
// runs from 300ms to 800ms with an easeOut, within a controller that has a
// total duration of 1000ms.
Animation<double> buildSubAnimation(
    AnimationController controller, Duration begin, Duration end, Curve curve) {
  int ttlT = controller.duration?.inMicroseconds ?? 0;
  int beginT = begin.inMicroseconds, endT = end.inMicroseconds;
  return CurvedAnimation(
    parent: controller,
    curve: Interval(beginT / ttlT, endT / ttlT, curve: curve),
  );
}


// Function for Animate callbacks.
typedef FXAnimateCallback = void Function(
  AnimationController controller,
);


// FXManager provides a common interface for FXAnimate and FXAnimateList for attaching FX extensions to.
mixin FXManager<T> {
  T addFX(AbstractFX fx) => throw (UnimplementedError());
  T addFXList(List<AbstractFX> fx) => throw (UnimplementedError());
}