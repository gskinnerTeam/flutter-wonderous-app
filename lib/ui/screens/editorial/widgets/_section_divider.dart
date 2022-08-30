part of '../editorial_screen.dart';

class _SectionDivider extends StatefulWidget {
  const _SectionDivider(this.scrollNotifier, this.sectionNotifier, {Key? key, required this.index}) : super(key: key);
  final int index;
  final ValueNotifier<double> scrollNotifier;
  final ValueNotifier<int> sectionNotifier;

  @override
  State<_SectionDivider> createState() => _SectionDividerState();
}

class _SectionDividerState extends State<_SectionDivider> with SingleTickerProviderStateMixin {
  final _isActivated = ValueNotifier(false);

  double _getSwitchPt(BuildContext c) => c.heightPx * .5;

  void _checkPosition(BuildContext context) {
    final yPos = ContextUtils.getGlobalPos(context)?.dy;
    if (yPos == null || yPos < 0) return;
    // Only allow headers to switch if it's above the switch pt
    bool activated = yPos < _getSwitchPt(context);
    if (activated != _isActivated.value) {
      scheduleMicrotask(() {
        // When activated, set our index as active. When de-activated, set it to the index before ours (index - 1).
        int newIndex = activated ? widget.index : widget.index - 1;
        widget.sectionNotifier.value = newIndex;
      });
      _isActivated.value = activated;
    }
  }

  @override
  Widget build(BuildContext _) {
    // When scroll position changes, the divider needs to check whether it should mark itself as the active index
    return ValueListenableBuilder<double>(
      valueListenable: widget.scrollNotifier,
      builder: (context, value, _) {
        _checkPosition(context);
        return ValueListenableBuilder<bool>(
          valueListenable: _isActivated,
          builder: (_, value, __) => Padding(
            padding: EdgeInsets.symmetric(vertical: $styles.insets.xl * 2),
            child: CompassDivider(isExpanded: value),
          ),
        );
      },
    );
  }
}
