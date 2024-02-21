import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/utils/context_utils.dart';

class AnimatedListItem extends StatelessWidget {
  const AnimatedListItem({super.key, required this.scrollPos, required this.builder});
  final ValueNotifier<double> scrollPos;
  final Widget Function(BuildContext context, double pctVisible) builder;

  @override
  Widget build(BuildContext context) {
    // Use Animate.toggle to build the child twice, this will allow it to properly measure its size and position.
    return Animate().toggle(
      builder: (_, value, __) => ValueListenableBuilder(
        valueListenable: scrollPos,
        builder: (_, value, __) {
          return LayoutBuilder(
            builder: (_, constraints) {
              Offset? pos = ContextUtils.getGlobalPos(context);
              final yPos = pos?.dy;
              final widgetHeight = constraints.maxHeight;
              double pctVisible = 0;
              if (yPos != null) {
                final amtVisible = context.heightPx - yPos;
                pctVisible = (amtVisible / widgetHeight * .5).clamp(0, 1);
              }
              return builder(context, pctVisible);
            },
          );
        },
      ),
    );
  }
}

/// Takes a scroll position notifier and a child.
/// Scales its child as it scrolls onto screen for a nice effect.
class ScalingListItem extends StatelessWidget {
  const ScalingListItem({super.key, required this.scrollPos, required this.child});
  final ValueNotifier<double> scrollPos;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedListItem(
      scrollPos: scrollPos,
      builder: (_, pctVisible) {
        final scale = 1.35 - pctVisible * .35;
        return ClipRect(
          child: Transform.scale(scale: scale, child: child),
        );
      },
    );
  }
}
