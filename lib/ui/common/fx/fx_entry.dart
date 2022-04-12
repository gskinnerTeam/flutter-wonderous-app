part of 'fx.dart';

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
    return _buildAnimation(controller, begin, end, curve ?? this.curve);
  }
}
