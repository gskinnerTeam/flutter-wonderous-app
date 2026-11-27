import 'package:wonders/common_libs.dart';

/// Lays [child] out at the full available width (so text wraps normally), then scales it down only if it is still
/// too large for the available space. At normal text scales this has no visual effect; at very large text scales it
/// prevents overflow in areas with a fixed size.
///
/// Unlike a bare [FittedBox], which gives its child unbounded constraints (making multi-line text render on a single
/// line and then shrink), this keeps the child's width bounded so it wraps first and only shrinks as a last resort.
class ScaleDownToFit extends StatelessWidget {
  const ScaleDownToFit({super.key, required this.child, this.alignment = Alignment.topCenter});
  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        // Without a bounded width there is nothing to wrap against, so fall back to plain scaling.
        if (!constraints.hasBoundedWidth) return FittedBox(fit: BoxFit.scaleDown, alignment: alignment, child: child);
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: alignment,
          child: SizedBox(width: constraints.maxWidth, child: child),
        );
      },
    );
  }
}
