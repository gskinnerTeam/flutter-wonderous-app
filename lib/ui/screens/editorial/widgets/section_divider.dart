part of '../editorial_screen.dart';

class _SectionDivider extends StatefulWidget {
  const _SectionDivider(this.scrollNotifier, this.sectionNotifier, {Key? key, required this.index}) : super(key: key);
  final int index;
  final ValueNotifier<double> scrollNotifier;
  final ValueNotifier<int> sectionNotifier;

  @override
  State<_SectionDivider> createState() => _SectionDividerState();
}

class _SectionDividerState extends State<_SectionDivider> {
  final _isActivated = ValueNotifier(false);
  final _tweenDuration = 1.5.seconds;
  double _switchPt(BuildContext c) => c.heightPx * .5;

  void _checkPosition(BuildContext context) {
    final rb = context.findRenderObject() as RenderBox?;
    if (rb != null) {
      final yPos = rb.localToGlobal(Offset.zero).dy;
      if (yPos < 0) return;
      // Only allow headers to switch if it's above the switch pt, but below the _switchArea
      bool activated = yPos < _switchPt(context);
      if (activated != _isActivated.value) {
        scheduleMicrotask(() {
          // When activated, dispatch index. Otherwise index - 1
          int index = activated ? widget.index : widget.index - 1;
          widget.sectionNotifier.value = index;
          print('dispatch${DateTime.now().millisecondsSinceEpoch}');
        });
        _isActivated.value = activated;
      }
    }
  }

  @override
  Widget build(BuildContext _) {
    return ValueListenableBuilder<double>(
      valueListenable: widget.scrollNotifier,
      builder: (context, value, child) {
        _checkPosition(context);
        return child!;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isActivated,
        builder: (context, value, __) {
          final tweenDuration = 1.5.seconds;
          return AnimatedContainer(
            duration: tweenDuration,
            curve: Curves.easeOutBack,
            padding: EdgeInsets.symmetric(
              horizontal: value ? 30 : context.widthPx / 4,
            ),
            child: Row(
              children: [
                Expanded(child: Divider(height: 1, thickness: 2, color: context.colors.accent2)),
                AnimatedRotation(
                  duration: tweenDuration,
                  curve: Curves.easeOutBack,
                  turns: value ? 0 : .5,
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: SvgPicture.asset('assets/images/compass-full.svg'),
                  ),
                ),
                Expanded(child: Divider(height: 1, thickness: 2, color: context.colors.accent2)),
              ],
            ),
          );
        },
      ),
    );
  }
}
