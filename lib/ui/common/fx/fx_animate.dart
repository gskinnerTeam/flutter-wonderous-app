import 'dart:collection';
import 'package:flutter/widgets.dart';

import 'fx.dart';

typedef ReparentChildBuilder = Widget Function(Widget parent, Widget child);

/// FXAnimate makes adding beautiful animated effects (FX) to your widgets
/// simple. It supports both a declarative and chained API. The latter is exposed
/// via the `Widget.fx` extension, which simply wraps the widget in FXAnimate.
///
///    // declarative:
///    FXAnimate(child: foo, fx: [FadeFX(), ScaleFX()])
///    // equivalent chained API:
///    foo.fx().fade().scale() // equivalent to above
/// 
/// Effects are always run in parallel (ie. the fade and scale effects in the
/// example above would be run simultaneously), but you can apply delays to
/// offset them or run them in sequence.
///
/// All effects classes are immutable, and can be shared between FXAnimate
/// instances, which lets you create libraries of effects to reuse throughout
/// your app.
///
///    FadeFX fadeIn = FadeFX(duration: 100.ms, curve: Curves.easeOut);
///    ScaleFX scaleIn = ScaleFX(begin: 0.8, curve: Curves.easeIn);
///    List<AbstractFX> transitionIn = [fadeIn, scaleIn];
///    // then:
///    FXAnimate(child: foo, fx:transitionIn)
///    foo.fx(fx:transitionIn)
///
/// Effects inherit some of their properties (delay, duration, curve) from
/// previous effects if unspecified. So in the examples above, the scale will use
/// the same duration as the fade that precedes it. All effects have
/// reasonable defaults, so they can be used simply: `foo.fx().fade()`
/// 
/// Note that all effects are composed together, not run sequentially. For example,
/// the following would not fade in myWidget, because the fadeOut effect would still be
/// applying an opacity of 0:
/// 
///    myWidget.fx().fadeOut(duration: 200.ms).fade(delay: 200.ms)

// ignore: must_be_immutable
class FXAnimate extends StatefulWidget with FXManager<FXAnimate> {
  /// Default duration for effects.
  static Duration defaultDuration = const Duration(milliseconds: 300);

  /// Default curve for effects.
  static Curve defaultCurve = Curves.linear;

  /// Types to reparent, mapped to a method that handles that type. This is used 
  /// to make it easy to work with widgets that require specific parents. For example,
  /// the Positioned widget, which needs its immediate parent to be a Stack.
  /// 
  /// Handles Flexible, Positioned, and Expanded by default, but you can add additional
  /// handlers as appropriate.
  static Map reparentTypes = <Type, ReparentChildBuilder>{
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
        child: child,
      );
    },
    Expanded: (parent, child) {
      Expanded o = parent as Expanded;
      return Expanded(key: o.key, flex: o.flex, child: child);
    }
  };

  /// Creates an FXAnimate instance that will manage effects and apply them to the
  /// specified child.
  FXAnimate({
    Key? key,
    this.child = const SizedBox.shrink(),
    List<AbstractFX>? fx,
    this.onComplete,
    this.onInit,
    this.delay = Duration.zero,
  }) : super(key: key) {
    _entries = [];
    if (fx != null) addFXList(fx);
  }

  /// The widget to apply effects to.
  final Widget child;

  /// A duration to delay before running the applied effects.
  final Duration delay;

  /// Called when all effects complete. Provides an opportunity to
  /// manipulate the AnimationController (ex. to loop, reverse, etc).
  final FXAnimateCallback? onComplete;

  /// Called when the FXAnimate's state initializes. Provides an opportunity to
  /// manipulate the AnimationController (ex. to loop, reverse, etc).
  final FXAnimateCallback? onInit;

  late final List<FXEntry> _entries;
  Duration _duration = Duration.zero;
  FXEntry? _lastEntry;

  /// The total duration for all effects.
  Duration get duration => _duration;

  @override
  State<FXAnimate> createState() => _FXAnimateState();

  /// Adds an effect. This is mostly used by FX extension methods to append effects
  /// to a FXAnimate instance.
  @override
  FXAnimate addFX(AbstractFX fx) {
    Duration begin = delay + (fx.delay ?? _lastEntry?.fx.delay ?? Duration.zero);
    FXEntry entry = FXEntry(
      fx: fx,
      begin: begin,
      end: begin + (fx.duration ?? _lastEntry?.fx.duration ?? FXAnimate.defaultDuration),
      curve: fx.curve ?? _lastEntry?.curve ?? FXAnimate.defaultCurve,
    );
    _entries.add(entry);
    _lastEntry = entry;
    if (entry.end > _duration) {
      _duration = entry.end;
    }
    return this;
  }
}

class _FXAnimateState extends State<FXAnimate> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this)..duration = widget._duration;

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener(_handleAnimationStatus);
    _controller.forward(); // TODO: Maybe add widget.autoPlay?
    widget.onInit?.call(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FXAnimate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._duration != widget._duration) {
      _controller.duration = widget._duration;
    }
  }

  void _handleAnimationStatus(status) {
    if (status == AnimationStatus.completed) {
      widget.onComplete?.call(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child, parent = child;
    ReparentChildBuilder? reparent = FXAnimate.reparentTypes[child.runtimeType];
    if (reparent != null) child = (child as dynamic).child;
    for (FXEntry entry in widget._entries) {
      child = entry.fx.build(context, child, _controller, entry);
    }
    return reparent?.call(parent, child) ?? child;
  }
}

/// Wraps the target Widget in a FXAnimate instance. Ex. `myWidget.fx()` is equivalent
/// to `FXAnimate(child: myWidget)`.
extension FXWidgetExtensions on Widget {
  FXAnimate fx({
    Key? key,
    List<AbstractFX>? fx,
    FXAnimateCallback? onComplete,
    FXAnimateCallback? onInit,
    Duration delay = Duration.zero,
  }) =>
      FXAnimate(key: key, child: this, fx: fx, onComplete: onComplete, onInit: onInit, delay: delay);
}

/// Applies animated effects to a list of widgets. It does this by wrapping each
/// widget in FXAnimate, and then proxying addFX calls to all instances. It can
/// also offset the timing of each widget's animation via `interval`.
///
/// For example, this would fade and scale every item in the Column, offsetting
/// the start of each by 100 milliseconds:
///
///    Column(children: [foo, bar, baz].fx(interval: 100.ms).fade().scale())
///
/// Like FXAnimate, it can also be used declaratively. The following is
/// equivalent to the above example.
///
///    Column(
///      children: FXAnimateList(
///        fx: [Fade(), Scale()],
///        interval: 100.ms,
///        children:[foo, bar, baz],
///      )
///    )
class FXAnimateList<T extends Widget> extends ListBase<Widget> with FXManager<FXAnimateList> {
  // Specifies a default interval to use for new FXAnimateList instances.
  static Duration defaultInterval = Duration.zero;

  /// Types to completely ignore in a list. For example, it is unlikely you want to
  /// animate Spacer widgets in a list. You can modify this list as appropriate.
  static Set<Type> ignoreTypes = {Spacer};

  FXAnimateList({
    required List<Widget> children,
    List<AbstractFX>? fx,
    Duration? interval,
    VoidCallback? onComplete,
  }) {
    // build new list, wrapping items in FXCore
    for (int i = 0; i < children.length; i++) {
      Widget child = children[i];
      Type type = child.runtimeType;
      // add onComplete to last child, stripping the controller param:
      FXAnimateCallback? f = i == children.length - 1 && onComplete != null ? (_) => onComplete() : null;
      if (!ignoreTypes.contains(type)) {
        child = FXAnimate(child: child, delay: (interval ?? Duration.zero) * i, onComplete: f);
        _managers.add(child as FXAnimate);
      }
      _widgets.add(child);
    }
    if (fx != null) addFXList(fx);
  }

  final List<Widget> _widgets = [];
  final List<FXAnimate> _managers = [];
  
  /// Adds an effect. This is mostly used by FX extension methods to append effects
  /// to a FXAnimate instance.
  @override
  FXAnimateList addFX(AbstractFX fx) {
    for (FXAnimate manager in _managers) {
      manager.addFX(fx);
    }
    return this;
  }

  @override
  FXAnimateList addFXList(List<AbstractFX> fx) {
    for (FXAnimate manager in _managers) {
      manager.addFXList(fx);
    }
    return this;
  }

  // concrete implementations required when extending ListBase:
  @override
  set length(int length) {
    _widgets.length = length;
  }

  @override
  int get length => _widgets.length;
  @override
  Widget operator [](int index) => _widgets[index];
  @override
  void operator []=(int index, Widget value) {
    _widgets[index] = value;
  }
}

/// Wraps the target List<Widget> in a FXAnimateList instance. Ex. `[foo, bar].fx()` is equivalent
/// to `FXAnimateList(children: [foo, bar])`.
extension FXListExtensions on List<Widget> {
  FXAnimateList fx({List<AbstractFX>? fx, Duration? interval, VoidCallback? onComplete}) =>
      FXAnimateList(children: this, fx: fx, interval: interval, onComplete: onComplete);
}

/// Because effects classes (AbstractFX) are immutable and may be reused between
/// multiple FXAnimate instances, an FXEntry is created to store values that may
/// be different between instances. For example, due to `interval` offsets, or
/// from inheriting values from prior FX in the chain.
@immutable
class FXEntry {
  /// The begin time for this entry.
  final Duration begin;

  /// The end time for this entry.
  final Duration end;

  /// The curve used by this entry.
  final Curve curve;

  /// The effect associated with this entry.
  final AbstractFX fx;

  const FXEntry({
    required this.fx,
    required this.begin,
    required this.end,
    required this.curve,
  });

  /// Builds a sub-animation based on the properties of this entry.
  Animation<double> buildAnimation(AnimationController controller, {Curve? curve}) {
    return buildSubAnimation(controller, begin, end, curve ?? this.curve);
  }
}

/// Builds a sub-animation to the provided controller that runs from start to
/// end, with the provided curve. For example, it could create an animation that
/// runs from 300ms to 800ms with an easeOut, within a controller that has a
/// total duration of 1000ms.
/// 
/// Mostly used by effects classes.
Animation<double> buildSubAnimation(AnimationController controller, Duration begin, Duration end, Curve curve) {
  int ttlT = controller.duration?.inMicroseconds ?? 0;
  int beginT = begin.inMicroseconds, endT = end.inMicroseconds;
  return CurvedAnimation(
    parent: controller,
    curve: Interval(beginT / ttlT, endT / ttlT, curve: curve),
  );
}

/// Function signature for FXAnimate callbacks.
typedef FXAnimateCallback = void Function(
  AnimationController controller,
);

/// Provides a common interface for FXAnimate and FXAnimateList for attaching FX extensions to.
mixin FXManager<T> {
  T addFX(AbstractFX fx) => throw (UnimplementedError());
  T addFXList(List<AbstractFX> fx) {
    for (AbstractFX o in fx) {
      addFX(o);
    }
    return this as T;
  }
}
