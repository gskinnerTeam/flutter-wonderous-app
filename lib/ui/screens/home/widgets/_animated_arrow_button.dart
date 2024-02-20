part of '../wonders_home_screen.dart';

/// An arrow that fades out, then fades back in and slides down, ending in it's original position with full opacity.
class _AnimatedArrowButton extends StatelessWidget {
  _AnimatedArrowButton({required this.onTap, required this.semanticTitle});

  final String semanticTitle;
  final VoidCallback onTap;

  // Fades to 0 and back to 1
  final _fadeOutIn = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: .5),
    TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: .5),
  ]);

  // Holds top alignment for first half, then jumps down and slides back up
  final _slideDown = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1, end: 1), weight: .5),
    TweenSequenceItem(tween: Tween(begin: -1, end: 1), weight: .5)
  ]);

  @override
  Widget build(BuildContext context) {
    final Duration duration = $styles.times.med;
    final btnLbl = $strings.animatedArrowSemanticSwipe(semanticTitle);
    return AppBtn.basic(
      semanticLabel: btnLbl,
      onPressed: onTap,
      child: SizedBox(
        height: 80,
        width: 50,
        child: Animate(
          effects: [
            CustomEffect(builder: _buildOpacityTween, duration: duration, curve: Curves.easeOut),
            CustomEffect(builder: _buildSlideTween, duration: duration, curve: Curves.easeOut),
          ],
          child: Transform.rotate(
            angle: pi * .5,
            child: Icon(Icons.chevron_right, size: 42, color: $styles.colors.white),
          ),
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
