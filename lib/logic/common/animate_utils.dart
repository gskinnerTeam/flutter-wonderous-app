import 'package:wonders/common_libs.dart';

// ignore: must_be_immutable
class NeverAnimate extends Animate {
  NeverAnimate({super.key, super.child});

  @override
  State<NeverAnimate> createState() => _NeverAnimateState();
}

class _NeverAnimateState extends State<NeverAnimate> {
  @override
  Widget build(BuildContext context) => widget.child;
}

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
    ? NeverAnimate(child: this)
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