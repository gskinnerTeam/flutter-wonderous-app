import 'package:wonders/common_libs.dart';

extension MaybeAnimateExtension on Widget {
  Animate maybeAnimate({
    Key? key,
    List<Effect>? effects,
    AnimateCallback? onInit,
    AnimateCallback? onPlay,
    AnimateCallback? onComplete,
    bool? autoPlay,
    Duration? delay,
    AnimationController? controller,
    Adapter? adapter,
    double? target,
    double? value,
  }) => $styles.disableAnimations
    ? Animate(child: this)
    : Animate(
        key: key,
        effects: effects,
        onInit: onInit,
        onPlay: onPlay,
        onComplete: onComplete,
        autoPlay: autoPlay,
        delay: delay,
        controller: controller,
        adapter: adapter,
        target: target,
        value: value,
        child: this,
      );
}
extension MaybeAnimateListExtension on List<Widget> {
  AnimateList<Widget> maybeAnimateList({
    List<Effect>? effects,
    AnimateCallback? onInit,
    AnimateCallback? onPlay,
    AnimateCallback? onComplete,
    bool? autoPlay,
    Duration? delay,
    Duration? interval
  }) => $styles.disableAnimations ? 
    AnimateList<Widget>(children: this) : 
    AnimateList<Widget>(
      effects: effects,
      onInit: onInit,
      onPlay: onPlay,
      onComplete: onComplete,
      autoPlay: autoPlay,
      delay: delay,
      interval: interval,
      children: this
    );
}

