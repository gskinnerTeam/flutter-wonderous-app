import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/collectible_item.dart';

/// Shows a [CollectibleItem], for a specific set of wonders.
/// The item is looked up via index, and expects that 3 items always exist for each wonder.
/// If `wonders` is empty, then the collectible is always shown.
class HiddenCollectible extends StatelessWidget with GetItMixin {
  HiddenCollectible(this.currentWonder,
      {super.key, required this.index, this.matches = const [], this.size = 64, this.focus})
      : assert(index <= 2, 'index should not exceed 2');
  final int index;
  final double size;
  final List<WonderType> matches;
  final WonderType currentWonder;
  final FocusNode? focus;
  @override
  Widget build(BuildContext context) {
    final data = collectiblesLogic.forWonder(currentWonder);
    assert(data.length == 3, 'Each wonder should have exactly 3 collectibles');
    if (matches.isNotEmpty && matches.contains(currentWonder) == false) {
      return SizedBox.shrink();
    }
    return CollectibleItem(data[index], size: size, focus: focus);
  }
}
