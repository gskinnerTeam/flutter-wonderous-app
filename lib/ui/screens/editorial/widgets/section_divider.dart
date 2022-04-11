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
  final _tweenDuration = 1.5.seconds;
  late final _dividersAnim = AnimationController(vsync: this, duration: _tweenDuration * .5);

  double _getSwitchPt(BuildContext c) => c.heightPx * .5;

  void _checkPosition(BuildContext context) {
    final yPos = ContextUtils.getGlobalPos(context)?.dy;
    if (yPos == null || yPos < 0) return;
    // Only allow headers to switch if it's above the switch pt, but below the _switchArea
    bool activated = yPos < _getSwitchPt(context);
    if (activated != _isActivated.value) {
      scheduleMicrotask(() {
        // When activated, set our index as active. When de-activated, set it to the index before ours (index - 1).
        int newIndex = activated ? widget.index : widget.index - 1;
        widget.sectionNotifier.value = newIndex;
        if (activated) {
          _dividersAnim.forward();
        } else {
          _dividersAnim.reverse();
        }
        debugPrint('index=$newIndex from $widget @  ${DateTime.now().millisecondsSinceEpoch}');
      });
      _isActivated.value = activated;
    }
  }

  @override
  Widget build(BuildContext _) {
    Widget buildAnimatedDivider(double size, {bool alignLeft = false}) {
      return AnimatedBuilder(
        animation: _dividersAnim,
        child: Divider(height: 1, thickness: .75, color: context.colors.accent2),
        builder: (_, child) {
          bool isReversing = _dividersAnim.status == AnimationStatus.reverse;
          final ease = isReversing ? Curves.easeIn : Curves.easeOut;
          return Transform.scale(
            scaleX: ease.transform(_dividersAnim.value),
            alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
            child: child!,
          );
        },
      );
    }

    return ValueListenableBuilder<double>(
      valueListenable: widget.scrollNotifier,
      // When scroll position changes, the divider needs to check whether it should mark itself as the active index
      builder: (context, value, child) {
        _checkPosition(context);
        return child!;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isActivated,
        builder: (context, value, __) {
          final double targetDividerScale = value ? 1 : 0;
          return Row(
            children: [
              Expanded(
                child: buildAnimatedDivider(targetDividerScale),
              ),
              AnimatedRotation(
                duration: _tweenDuration,
                curve: Curves.easeOutBack,
                turns: value ? 0 : .5,
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: SvgPicture.asset(SvgPaths.compassFull),
                ),
              ),
              Expanded(
                child: CenterLeft(
                  child: buildAnimatedDivider(targetDividerScale, alignLeft: true),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
