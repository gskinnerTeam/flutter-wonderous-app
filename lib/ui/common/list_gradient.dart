import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/gradient_container.dart';

/// Used for situations where the list content should blend into a background color.
/// Can be placed at the top or bottom of a list, using the `flip' option when on the bottom
class ListOverscollGradient extends StatelessWidget {
  const ListOverscollGradient({super.key, this.size = 100, this.color, this.bottomUp = false});
  final bool bottomUp;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? $styles.colors.black;
    return VtGradient([c.withOpacity(bottomUp ? 0 : 1), c.withOpacity(bottomUp ? 1 : 0)], const [0, 1], height: size);
  }
}
