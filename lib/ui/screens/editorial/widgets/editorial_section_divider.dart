part of '../editorial_screen.dart';

class _EditorialSectionDivider extends StatefulWidget {
  const _EditorialSectionDivider(this.scrollNotifier, {Key? key, required this.index}) : super(key: key);
  final int index;
  final ValueNotifier<double> scrollNotifier;

  @override
  State<_EditorialSectionDivider> createState() => _EditorialSectionDividerState();
}

class _EditorialSectionDividerState extends State<_EditorialSectionDivider> {
  final _isActivated = ValueNotifier(false);

  void _dispatchChangeNotification() {
    // When activated, dispatch index. Otherwise index - 1
    int index = _isActivated.value ? widget.index : widget.index - 1;
    SectionChangedNotification(index).dispatch(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: widget.scrollNotifier,
      builder: (_, value, child) {
        final rb = context.findRenderObject() as RenderBox?;
        if (rb != null) {
          final yPos = rb.localToGlobal(Offset.zero).dy;
          bool activated = (yPos < context.heightPx * .45);
          if (activated != _isActivated.value) {
            scheduleMicrotask(_dispatchChangeNotification);
            _isActivated.value = activated;
          }
        }
        return child!;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isActivated,
        builder: (_, value, __) {
          return Row(
            children: [
              Expanded(child: Divider(height: 1, thickness: 2, color: context.colors.accent2)),
              SizedBox(height: 32, width: 32, child: SvgPicture.asset('assets/images/compass-full.svg')),
              Expanded(child: Divider(height: 1, thickness: 2, color: context.colors.accent2)),
            ],
          );
        },
      ),
    );
  }
}
