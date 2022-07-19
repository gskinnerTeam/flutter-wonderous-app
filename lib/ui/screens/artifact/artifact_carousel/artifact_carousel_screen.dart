import 'dart:math' as math;

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/highlight_data.dart';
import 'package:wonders/ui/common/controls/app_page_indicator.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_bg.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_image.dart';

// TODO: review accessibility. Ex. should the "page" tap be a button so we can attach a semantic label?
// TODO: fix weird issue when resizing the window (low priority)

class ArtifactCarouselScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactCarouselScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactCarouselScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactCarouselScreen> {
  // Used to cap white background dimensions.
  static const double _maxElementWidth = 375;
  static const double _maxElementHeight = 700;

  // Locally store loaded artifacts.
  late List<HighlightData> _artifacts;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _artifacts = HighlightData.forWonder(widget.type);

    _controller = PageController(
      // start at a high offset so we can scroll backwards:
      initialPage: _artifacts.length * 9999,
      viewportFraction: 0.5,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePageBtn(int delta) {
    _controller.animateToPage(
      currentOffset.round() + delta,
      duration: $styles.times.fast,
      curve: Curves.easeOut,
    );
  }

  void _handleArtifactTap(int index) {
    HighlightData data = _artifacts[index % _artifacts.length];
    context.push(ScreenPaths.artifact(data.artifactId));
  }

  void _handleSearchButtonTap() {
    context.push(ScreenPaths.search(widget.type));
  }

  double get currentOffset {
    bool inited = _controller.hasClients && _controller.position.haveDimensions;
    return inited ? _controller.page! : _controller.initialPage * 1.0;
  }

  int get currentIndex => currentOffset.round() % _artifacts.length;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: $styles.colors.greyStrong,
      child: AnimatedBuilder(animation: _controller, builder: _screenBuilder),
    );
  }

  Widget _screenBuilder(BuildContext context, _) {
    final double backdropWidth = math.min(context.widthPx, _maxElementWidth);
    final double backdropHeight = math.min(context.heightPx * 0.65, _maxElementHeight);
    final bool small = backdropHeight / _maxElementHeight < 0.7;
    final HighlightData artifact = _artifacts[currentIndex];

    return Stack(children: [
      Positioned.fill(child: ArtifactCarouselBg(url: artifact.imageUrl)),
      Column(children: [
        SimpleHeader('ARTIFACTS', showBackBtn: false, isTransparent: true),
        Expanded(
          child: Stack(children: [
            // White arch, covering bottom half:
            BottomCenter(
              child: Container(
                width: backdropWidth,
                height: backdropHeight,
                decoration: BoxDecoration(
                  color: $styles.colors.offWhite.withOpacity(0.8),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(999)),
                ),
              ),
            ),

            // Carousel:
            PageView.builder(
              controller: _controller,
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                return ExcludeSemantics(
                  excluding: index != currentIndex,
                  child: ArtifactCarouselImage(
                    index: index,
                    currentPage: currentOffset,
                    artifact: _artifacts[index % _artifacts.length],
                    bottomPadding: backdropHeight,
                    maxWidth: backdropWidth,
                    maxHeight: backdropHeight,
                    onPressed: () => _handleArtifactTap(index),
                  ),
                );
              },
            ),

            Positioned.fill(right: context.widthPx * 0.75, child: _buildPageBtn(-1, 'Previous artifact')),
            Positioned.fill(left: context.widthPx * 0.75, child: _buildPageBtn(1, 'Next artifact')),

            // Text content
            BottomCenter(
              child: Container(
                width: backdropWidth,
                padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap($styles.insets.md),
                    _buildContent(context, artifact, backdropWidth, small),
                    Gap(small ? $styles.insets.md : $styles.insets.xl),
                    AppBtn.from(
                      text: 'Browse all artifacts',
                      icon: Icons.search,
                      expand: true,
                      onPressed: _handleSearchButtonTap,
                    ),
                    Gap(small ? $styles.insets.md : $styles.insets.lg),
                  ],
                ),
              ),
            ),
          ]),
        )
      ]),
    ]);
  }

  Widget _buildPageBtn(int offset, String label) {
    return Semantics(
      label: label,
      button: true,
      container: true,
      child: GestureDetector(
        excludeFromSemantics: true,
        onTapUp: (_) {
          HapticFeedback.mediumImpact();
          _handlePageBtn(offset);
        },
        behavior: HitTestBehavior.translucent,
      ),
    );
  }

  Widget _buildContent(BuildContext context, HighlightData artifact, double width, bool small) {
    return IgnorePointer(
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Text(
                artifact.culture.toUpperCase(),
                style: $styles.text.titleFont.copyWith(
                  color: $styles.colors.greyStrong,
                  fontSize: 14,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Gap($styles.insets.xxs),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: small ? 84 : 120,
                  alignment: Alignment.center,
                  child: Text(
                    artifact.title,
                    overflow: TextOverflow.ellipsis,
                    style: $styles.text.h2.copyWith(color: $styles.colors.black, height: 1.2),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                Gap($styles.insets.xxs),
                Text(artifact.date, style: $styles.text.body, textAlign: TextAlign.center),
              ],
            ).animate(key: ValueKey(artifact.artifactId)).fadeIn(),
            Gap(small ? $styles.insets.sm : $styles.insets.lg),
            AppPageIndicator(count: _artifacts.length, controller: _controller, semanticPageTitle: 'artifact'),
          ],
        ),
      ),
    );
  }
}
