import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'effects/effects.dart';

export 'effects/effects.dart';
export 'num_duration_extensions.dart';

/// The builder type used by [Animate.reparentTypes]. It must accept an existing
/// parent widget, and rebuild it with the provided child. In effect, it clones
/// the provided parent widget with the new child.
typedef ReparentChildBuilder = Widget Function(Widget parent, Widget child);

/// The AnimateEffects library makes adding beautiful animated effects to your widgets
/// simple. It supports both a declarative and chained API. The latter is exposed
/// via the `Widget.animate` extension, which simply wraps the widget in `Animate`.
///
///    // declarative:
///    Animate(child: foo, effects: [FadeEffect(), ScaleEffect()])
///    // equivalent chained API:
///    foo.animate().fade().scale() // equivalent to above
///
/// Effects are always run in parallel (ie. the fade and scale effects in the
/// example above would be run simultaneously), but you can apply delays to
/// offset them or run them in sequence.
///
/// All effects classes are immutable, and can be shared between `Animate`
/// instances, which lets you create libraries of effects to reuse throughout
/// your app.
///
///     List<Effect> transitionIn = [
///       FadeEffect(duration: 100.ms, curve: Curves.easeOut),
///       ScaleEffect(begin: 0.8, curve: Curves.easeIn)
///     ];
///     // then:
///     Animate(child: foo, effects: transitionIn)
///     // or:
///     foo.animate(effects: transitionIn)
///
/// Effects inherit some of their properties (delay, duration, curve) from the
/// previous effect if unspecified. So in the examples above, the scale will use
/// the same duration as the fade that precedes it. All effects have
/// reasonable defaults, so they can be used simply: `foo.animate().fade()`
///
/// Note that all effects are composed together, not run sequentially. For example,
/// the following would not fade in myWidget, because the fadeOut effect would still be
/// applying an opacity of 0:
///
///    myWidget.animate().fadeOut(duration: 200.ms).fadeIn(delay: 200.ms)

// ignore: must_be_immutable
class Animate extends StatefulWidget with AnimateManager<Animate> {
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

  /// Creates an Animate instance that will manage effects and apply them to the
  /// specified child.
  Animate({
    Key? key,
    this.child = const SizedBox.shrink(),
    List<Effect>? effects,
    this.onComplete,
    this.onInit,
    this.delay = Duration.zero,
  }) : super(key: key) {
    _entries = [];
    if (effects != null) addEffects(effects);
  }

  /// The widget to apply effects to.
  final Widget child;

  /// A duration to delay before running the applied effects.
  final Duration delay;

  /// Called when all effects complete. Provides an opportunity to
  /// manipulate the [AnimationController] (ex. to loop, reverse, etc).
  final AnimateCallback? onComplete;

  /// Called when the instance's state initializes. Provides an opportunity to
  /// manipulate the [AnimationController] (ex. to loop, reverse, etc).
  final AnimateCallback? onInit;

  late final List<EffectEntry> _entries;
  Duration _duration = Duration.zero;
  EffectEntry? _lastEntry;

  /// The total duration for all effects.
  Duration get duration => _duration;

  @override
  State<Animate> createState() => _AnimateState();

  /// Adds an effect. This is mostly used by `Effect` extension methods to append effects
  /// to an `Animate` instance.
  @override
  Animate addEffect(Effect effect) {
    Duration begin = delay + (effect.delay ?? _lastEntry?.effect.delay ?? Duration.zero);
    EffectEntry entry = EffectEntry(
      effect: effect,
      begin: begin,
      end: begin + (effect.duration ?? _lastEntry?.effect.duration ?? Animate.defaultDuration),
      curve: effect.curve ?? _lastEntry?.curve ?? Animate.defaultCurve,
    );
    _entries.add(entry);
    _lastEntry = entry;
    if (entry.end > _duration) _duration = entry.end;
    return this;
  }
}

class _AnimateState extends State<Animate> with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(covariant Animate oldWidget) {
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
    ReparentChildBuilder? reparent = Animate.reparentTypes[child.runtimeType];
    if (reparent != null) child = (child as dynamic).child;
    for (EffectEntry entry in widget._entries) {
      child = entry.effect.build(context, child, _controller, entry);
    }
    return reparent?.call(parent, child) ?? child;
  }
}

/// Wraps the target Widget in an Animate instance. Ex. `myWidget.animate()` is equivalent
/// to `Animate(child: myWidget)`.
extension AnimateWidgetExtensions on Widget {
  Animate animate({
    Key? key,
    List<Effect>? effects,
    AnimateCallback? onComplete,
    AnimateCallback? onInit,
    Duration delay = Duration.zero,
  }) =>
      Animate(
        key: key,
        child: this,
        effects: effects,
        onComplete: onComplete,
        onInit: onInit,
        delay: delay,
      );
}

/// Applies animated effects to a list of widgets. It does this by wrapping each
/// widget in [Animate], and then proxying `add` calls to all instances. It can
/// also offset the timing of each widget's animation via `interval`.
///
/// For example, this would fade and scale every item in the Column, offsetting
/// the start of each by 100 milliseconds:
///
///    Column(children: [foo, bar, baz].animate(interval: 100.ms).fade().scale())
///
/// Like [Animate], it can also be used declaratively. The following is
/// equivalent to the above example.
///
///    Column(
///      children: AnimateList(
///        effects: [FadeEffect(), ScaleEffect()],
///        interval: 100.ms,
///        children: [foo, bar, baz],
///      )
///    )
class AnimateList<T extends Widget> extends ListBase<Widget> with AnimateManager<AnimateList> {
  // Specifies a default interval to use for new `AnimateList` instances.
  static Duration defaultInterval = Duration.zero;

  /// Types to completely ignore in a list. For example, it is unlikely you want to
  /// animate Spacer widgets in a list. You can modify this list as appropriate.
  static Set<Type> ignoreTypes = {Spacer};

  AnimateList({
    required List<Widget> children,
    List<Effect>? effects,
    Duration? interval,
    VoidCallback? onComplete,
  }) {
    // build new list, wrapping each child in Animate
    for (int i = 0; i < children.length; i++) {
      Widget child = children[i];
      Type type = child.runtimeType;
      // add onComplete to last child, stripping the controller param:
      AnimateCallback? f = i == children.length - 1 && onComplete != null ? (_) => onComplete() : null;
      if (!ignoreTypes.contains(type)) {
        child = Animate(child: child, delay: (interval ?? Duration.zero) * i, onComplete: f);
        _managers.add(child as Animate);
      }
      _widgets.add(child);
    }
    if (effects != null) addEffects(effects);
  }

  final List<Widget> _widgets = [];
  final List<Animate> _managers = [];

  /// Adds an effect. This is mostly used by `Effect` extension methods to append effects
  /// to an `AnimateList` instance.
  @override
  AnimateList addEffect(Effect effect) {
    for (Animate manager in _managers) {
      manager.addEffect(effect);
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

/// Wraps the target List<Widget> in a [AnimateList] instance. Ex. `[foo, bar].animate()` is equivalent
/// to `AnimateList(children: [foo, bar])`.
extension AnimateListExtensions on List<Widget> {
  AnimateList animate({List<Effect>? effects, Duration? interval, VoidCallback? onComplete}) =>
      AnimateList(children: this, effects: effects, interval: interval, onComplete: onComplete);
}

/// Because [Effect] classes are immutable and may be reused between
/// multiple [Animate] (or [AnimateList]) instances, an `EffectEntry` is created to store values that may
/// be different between instances. For example, due to `interval` offsets, or
/// from inheriting values from prior effects in the chain.
@immutable
class EffectEntry {
  /// The begin time for this entry.
  final Duration begin;

  /// The end time for this entry.
  final Duration end;

  /// The curve used by this entry.
  final Curve curve;

  /// The effect associated with this entry.
  final Effect effect;

  const EffectEntry({
    required this.effect,
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

/// Function signature for `Animate` callbacks.
typedef AnimateCallback = void Function(
  AnimationController controller,
);

/// Provides a common interface for [Animate] and [AnimateList] for attaching extensions to.
mixin AnimateManager<T> {
  T addEffect(Effect effect) => throw (UnimplementedError());
  T addEffects(List<Effect> effects) {
    for (Effect o in effects) {
      addEffect(o);
    }
    return this as T;
  }
}
