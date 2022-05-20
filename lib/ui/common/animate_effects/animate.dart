import 'package:flutter/widgets.dart';
import 'animate_effects.dart';

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
///     myWidget.animate().fadeOut(duration: 200.ms).fadeIn(delay: 200.ms)
///
/// See [SwapEffect] for one approach to work around this.

// ignore: must_be_immutable
class Animate extends StatefulWidget with AnimateManager<Animate> {
  /// Default duration for effects.
  static Duration defaultDuration = const Duration(milliseconds: 300);

  /// Default curve for effects.
  static Curve defaultCurve = Curves.linear;

  /// Widget types to reparent, mapped to a method that handles that type. This is used
  /// to make it easy to work with widgets that require specific parents. For example,
  /// the [Positioned] widget, which needs its immediate parent to be a [Stack].
  ///
  /// Handles [Flexible], [Positioned], and [Expanded] by default, but you can add additional
  /// handlers as appropriate. Example, this would add support for a hypothetical
  /// "AlignPositioned" widget, that has an `alignment` property.
  ///
  ///     Animate.reparentTypes[AlignPositioned] = (parent, child) {
  ///       AlignPositioned o = parent as AlignPositioned;
  ///       return AlignPositioned(alignment: o.alignment, child: child);
  ///     }
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

  /// Creates an Animate instance that will manage a list of effects and apply
  /// them to the specified child.
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

  /// Adds an effect. This is mostly used by [Effect] extension methods to append effects
  /// to an [Animate] instance.
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
    _controller.forward(); // TODO: GDS: Maybe add widget.autoPlay?
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
        effects: effects,
        onComplete: onComplete,
        onInit: onInit,
        delay: delay,
        child: this,
      );
}

/// The builder type used by [Animate.reparentTypes]. It must accept an existing
/// parent widget, and rebuild it with the provided child. In effect, it clones
/// the provided parent widget with the new child.
typedef ReparentChildBuilder = Widget Function(Widget parent, Widget child);

/// Function signature for `Animate` callbacks.
typedef AnimateCallback = void Function(AnimationController controller);
