part of '../editorial_screen.dart';

class _AppBar extends StatelessWidget {
  const _AppBar(this.wonderType, {Key? key, required this.sectionIndex, required this.scrollPos}) : super(key: key);
  final WonderType wonderType;
  final ValueNotifier<int> sectionIndex;
  final ValueNotifier<double> scrollPos;
  final _titleValues = const [
    'Facts and History',
    'Construction',
    'Location Info',
  ];

  @override
  Widget build(BuildContext context) {
    ArchType? archType;
    switch (wonderType) {
      case WonderType.tajMahal:
        archType = ArchType.spade;
        break;
      default:
        archType = ArchType.pyramid;
    }
    return LayoutBuilder(builder: (_, constraints) {
      bool showOverlay = constraints.biggest.height < 300;

      return Stack(
        fit: StackFit.expand,
        children: [
          /// Masked image
          AnimatedSwitcher(
            duration: context.times.fast,
            switchInCurve: Curves.easeIn,
            child: Stack(
              key: ValueKey(showOverlay),
              fit: StackFit.expand,
              children: [
                ClipPath(
                  // Switch arch type to Rect if we are showing the title bar
                  clipper: showOverlay ? null : ArchClipper(archType!),
                  child: ScalingListItem(
                    scrollPos: scrollPos,
                    child: Image.asset(wonderType.photo1, fit: BoxFit.cover),
                  ),
                ),
                if (showOverlay) ...[
                  /// Colored overlay
                  ClipRect(
                    child: ColoredBox(color: wonderType.bgColor.withOpacity(.8))
                        .gTweener
                        .move(from: Offset(0, -200))
                        .withDelay(.0.seconds),
                  ),
                ],
              ],
            ),
          ),

          /// Titlebar
          BottomCenter(
            child: ClipRect(
              child: ValueListenableBuilder<int>(
                valueListenable: sectionIndex,
                builder: (_, value, __) {
                  return _CircularTitleBar(
                    index: value,
                    titles: _titleValues,
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}