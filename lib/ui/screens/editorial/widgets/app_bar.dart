part of '../editorial_screen.dart';

// TODO: This needs to take the actual thumbnail for this widget
class _AppBar extends StatelessWidget {
  _AppBar(this.wonderType, {Key? key, required this.imageId, required this.sectionIndex}) : super(key: key);
  final String imageId;
  final WonderType wonderType;
  final ValueNotifier<int> sectionIndex;

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
                  clipper: ArchClipper(showOverlay ? ArchType.rect : archType!),
                  // TODO: Make helpers for photo1 etc
                  child:
                      Image.asset('assets/images/${wonders.getAssetFolder(wonderType)}/photo-1.png', fit: BoxFit.cover),
                ),
                if (showOverlay) ...[
                  /// Colored overlay
                  ClipRect(
                    child: ColoredBox(color: context.colors.wonderBg(wonderType).withOpacity(.8))
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
                    titles: const [
                      'Facts and History',
                      'Location Info',
                      'Construction',
                    ],
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
