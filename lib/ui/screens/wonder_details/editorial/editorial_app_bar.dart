part of 'wonder_editorial_screen.dart';

// TODO: This needs to take the actual thumbnail for this widget
class _EditorialAppBar extends StatelessWidget {
  const _EditorialAppBar(this.wonderType, {Key? key, required this.imageId}) : super(key: key);
  final String imageId;
  final WonderType wonderType;
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
      bool showTitleBar = constraints.biggest.height < 300;
      return AnimatedSwitcher(
        duration: context.times.fast,
        child: Stack(
          key: ValueKey(showTitleBar),
          fit: StackFit.expand,
          children: [
            /// Masked image
            ClipPath(
              // Switch arch type to Rect if we are showing the title bar
              clipper: ArchClipper(showTitleBar ? ArchType.rect : archType!),
              child: Image.asset('assets/images/${wonders.getAssetFolder(wonderType)}/photo1.jpg', fit: BoxFit.cover),
            ),

            if (showTitleBar) ...[
              /// Colored overlay
              ClipRect(
                child: ColoredBox(color: context.colors.wonderBg(wonderType).withOpacity(.8))
                    .gTweener
                    .move(from: Offset(0, -200))
                    .withDelay(.0.seconds),
              ),

              /// Titlebar
              BottomCenter(
                child: ClipRect(
                  child: _CircularTitleBar().gTweener.move(from: Offset(0, 100), curve: Curves.easeOut),
                ),
              )
            ],
          ],
        ),
      );
    });
  }
}
