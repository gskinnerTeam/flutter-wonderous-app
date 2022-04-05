part of 'wonder_editorial_screen.dart';

class _EditorialContent extends StatelessWidget {
  const _EditorialContent(this.data, {Key? key, required this.scrollNotifier}) : super(key: key);
  final WonderData data;
  final ValueNotifier<double> scrollNotifier;

  @override
  Widget build(BuildContext context) {
    void handleVideoPressed() => context.push(ScreenPaths.video('cnMa-Sm9H4k'));
    return Container(
      color: context.colors.bg,
      padding: EdgeInsets.all(context.insets.md),
      child: SeparatedColumn(
        separatorBuilder: () => Gap(context.insets.md),
        children: [
          LoremPlaceholder(dropCase: true),
          Theme(
            data: Theme.of(context).copyWith(textTheme: ThemeData.light().textTheme),
            child: Text('hello', style: context.textStyles.h1),
          ),
          LoremPlaceholder(),
          LoremPlaceholder(),
          _SectionDivider(scrollNotifier, index: 1),
          PlaceholderImage(height: 200),
          LoremPlaceholder(),
          LoremPlaceholder(),
          LoremPlaceholder(),
          _SectionDivider(scrollNotifier, index: 2),
          PlaceholderImage(height: 200),
          LoremPlaceholder(),
          LoremPlaceholder(),
          LoremPlaceholder(),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatefulWidget {
  const _SectionDivider(this.scrollNotifier, {Key? key, required this.index}) : super(key: key);
  final int index;
  final ValueNotifier<double> scrollNotifier;

  @override
  State<_SectionDivider> createState() => _SectionDividerState();
}

class _SectionDividerState extends State<_SectionDivider> {
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
          return Divider(height: 20, thickness: value ? 6 : 2, color: Colors.red);
        },
      ),
    );
  }
}
