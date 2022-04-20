part of '../wonders_home_screen.dart';

/// An arrow that fades out, then fades back in and slides down, ending in it's original position with full opacity.
class _AnimatedArrowButton extends StatelessWidget {
  const _AnimatedArrowButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final duration = context.times.slow;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: _FadingDownArrow(duration: duration),
    );
  }
}

/// FadingArrow - Fades In, Out, and back In
class _FadingDownArrow extends StatelessWidget {
  _FadingDownArrow({Key? key, required this.duration}) : super(key: key);
  final Duration duration;

  final _fadeOutIn = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: .5),
    TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: .5),
  ]);

  final _slideDown = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1, end: 1), weight: .5),
    TweenSequenceItem(tween: Tween(begin: -1, end: 1), weight: .5)
  ]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 50,
      child: FXAnimate(
        fx: [
          BuildFX(_buildOpacityTween, duration: duration, curve: Curves.easeOut),
          BuildFX(_buildSlideTween, duration: duration, curve: Curves.easeOut),
        ],
        child: Transform.rotate(
          angle: pi * .5,
          child: Icon(Icons.chevron_right, size: 42, color: context.colors.white),
        ),
      ),
    );
  }

  Widget _buildOpacityTween(BuildContext _, double value, Widget child) {
    final opacity = _fadeOutIn.evaluate(AlwaysStoppedAnimation(value));
    return Opacity(opacity: opacity, child: child);
  }

  Widget _buildSlideTween(BuildContext _, double value, Widget child) {
    double yOffset = _slideDown.evaluate(AlwaysStoppedAnimation(value));
    return Align(alignment: Alignment(0, -1 + yOffset * 2), child: child);
  }
}
