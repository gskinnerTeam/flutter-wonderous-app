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

  final _iconValues = const [
    'history.png',
    'construction.png',
    'geography.png',
  ];

  ArchType _getArchType() {
    switch (wonderType) {
      case WonderType.chichenItza:
        return ArchType.flatPyramid;
      case WonderType.christRedeemer:
        return ArchType.wideArch;
      case WonderType.colosseum:
        return ArchType.arch;
      case WonderType.greatWall:
        return ArchType.arch;
      case WonderType.machuPicchu:
        return ArchType.pyramid;
      case WonderType.petra:
        return ArchType.wideArch;
      case WonderType.pyramidsGiza:
        return ArchType.pyramid;
      case WonderType.tajMahal:
        return ArchType.spade;
    }
  }

  @override
  Widget build(BuildContext context) {
    final arch = _getArchType();
    return LayoutBuilder(builder: (_, constraints) {
      bool showOverlay = constraints.biggest.height < 300;
      return Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            duration: context.times.fast,
            switchInCurve: Curves.easeIn,
            child: Stack(
              key: ValueKey(showOverlay),
              fit: StackFit.expand,
              children: [
                /// Masked image
                ClipPath(
                  // Switch arch type to Rect if we are showing the title bar
                  clipper: showOverlay ? null : ArchClipper(arch),
                  child: ValueListenableBuilder<double>(
                    valueListenable: scrollPos,
                    builder: (_, value, child) {
                      double opacity = (.4 + (value / 1500)).clamp(0, 1);
                      return Opacity(opacity: opacity, child: child);
                    },
                    child: ScalingListItem(
                      scrollPos: scrollPos,
                      child: Image.asset(wonderType.photo1, fit: BoxFit.cover),
                    ),
                  ),
                ),

                /// Colored overlay
                if (showOverlay) ...[
                  ClipRect(
                    child: ColoredBox(
                      color: wonderType.bgColor.withOpacity(.8),
                    ).fx().fade(duration: context.times.fast),
                  ),
                ],
              ],
            ),
          ),

          /// Circular Titlebar
          BottomCenter(
            child: ValueListenableBuilder<int>(
              valueListenable: sectionIndex,
              builder: (_, value, __) {
                return _CircularTitleBar(
                  index: value,
                  titles: _titleValues,
                  icons: _iconValues,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
