part of 'wonder_editorial_screen.dart';

// TODO: This needs to take the actual thumbnail for this widget
class _CollapsingAppBar extends StatelessWidget {
  const _CollapsingAppBar(this.wonderType, {Key? key, required this.imageId}) : super(key: key);
  final String imageId;
  final WonderType wonderType;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      bool showTitleBar = constraints.biggest.height < 300;
      bool showCredits = constraints.biggest.height > 450;
      return AnimatedSwitcher(
        duration: context.times.fast,
        child: Stack(
          key: ValueKey(showTitleBar),
          fit: StackFit.expand,
          children: [
            /// Masked image
            ClipPath(
              // Switch arch type to Rect if we are showing the title bar
              clipper: ArchClipper(showTitleBar ? ArchType.rect : ArchType.spade),
              child: UnsplashPhoto(imageId, targetSize: (context.widthPx * 1.5).round()),
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
