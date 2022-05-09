import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/utils/context_utils.dart';

/// Takes a scroll position notifier and a child.
/// Scales its child as it scrolls onto screen for a nice effect.
class ScalingListItem extends StatelessWidget {
  const ScalingListItem({Key? key, required this.scrollPos, required this.child}) : super(key: key);
  final ValueNotifier<double> scrollPos;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Use a FxRunAnimated to build the child twice, this will allow it to properly measure its size and position.
    return FXRunAnimated(
      (_, value) => ValueListenableBuilder(
          valueListenable: scrollPos,
          builder: (_, value, __) {
            return LayoutBuilder(
              builder: (_, constraints) {
                final yPos = ContextUtils.getGlobalPos(context)?.dy;
                final widgetHeight = constraints.maxHeight;
                double scale = 1;
                if (yPos != null) {
                  final amtVisible = context.heightPx - yPos;
                  final pctVisible = (amtVisible / widgetHeight * .5).clamp(0, 1);
                  scale = 1.35 - pctVisible * .35;
                }

                return ClipRect(
                  child: Transform.scale(scale: scale, child: child),
                );
              },
            );
          }),
    );
  }
}
