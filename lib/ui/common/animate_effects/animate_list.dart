import 'dart:collection';
import 'package:flutter/widgets.dart';

import 'animate_effects.dart';


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
  /// Specifies a default interval to use for new `AnimateList` instances.
  static Duration defaultInterval = Duration.zero;

  /// Widget types to ignore in a list. By default, includes [Spacer].
  /// You can modify this list as appropriate. For example, to ignore a
  /// hypothetical "Gap" widget type:
  /// 
  ///     AnimateList.ignoreTypes.add(Gap);
  static Set<Type> ignoreTypes = {Spacer};

  /// Creates an AnimateList instance that will wrap all children in an [Animate]
  /// instance, and proxy any added effects to each of them.
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

  /// Adds an effect. This is mostly used by [Effect] extension methods to
  /// append effects to an [AnimateList] instance.
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

/// Wraps the target `List<Widget>` in a [AnimateList] instance.
/// Ex. `[foo, bar].animate()` is equivalent to `AnimateList(children: [foo, bar])`.
extension AnimateListExtensions on List<Widget> {
  AnimateList animate({List<Effect>? effects, Duration? interval, VoidCallback? onComplete}) =>
      AnimateList(children: this, effects: effects, interval: interval, onComplete: onComplete);
}