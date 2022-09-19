import 'dart:math' as math;
import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/highlight_data.dart';
import 'package:wonders/ui/common/controls/app_page_indicator.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/common/static_text_scale.dart';
part 'widgets/_blurred_image_bg.dart';
part 'widgets/_carousel_item.dart';

class ArtifactCarouselScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactCarouselScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactCarouselScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactCarouselScreen> {
  // Used to cap white background dimensions.
  static const double _maxElementWidth = 440;
  static const double _partialElementWidth = 0.9;
  static const double _maxElementHeight = 640;

  // Locally store loaded artifacts.
  late List<HighlightData> _artifacts;
  late PageController _controller;

  double get _currentOffset {
    bool hasOffset = _controller.hasClients && _controller.position.haveDimensions;
    return hasOffset ? _controller.page! : _controller.initialPage * 1.0;
  }

  final _currentIndex = ValueNotifier(0);

  HighlightData get _currentArtifact => _artifacts[_currentIndex.value];

  @override
  void initState() {
    super.initState();
    _artifacts = HighlightData.forWonder(widget.type);

    _controller = PageController(
      // start at a high offset so we can scroll backwards:
      initialPage: _artifacts.length * 9999,
      viewportFraction: 0.5,
    )..addListener(_handleCarouselScroll);
  }

  void _handleCarouselScroll() => _currentIndex.value = _currentOffset.round() % _artifacts.length;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleArtifactTap(int index) {
    int delta = index - _currentOffset.round();
    if (delta == 0) {
      HighlightData data = _artifacts[index % _artifacts.length];
      context.push(ScreenPaths.artifact(data.artifactId));
    } else {
      _controller.animateToPage(
        _currentOffset.round() + delta,
        duration: $styles.times.fast,
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSearchTap() {
    context.push(ScreenPaths.search(widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: $styles.colors.greyStrong,
      child: AnimatedBuilder(
        animation: _currentIndex,
        builder: (context, __) => _buildScreen(context),
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    final double w = context.widthPx;
    final double backdropWidth = w <= _maxElementWidth ? w : min(w * _partialElementWidth, _maxElementWidth);
    final double backdropHeight = math.min(context.heightPx * 0.65, _maxElementHeight);
    final bool small = backdropHeight / _maxElementHeight < 0.7;

    return Stack(
      children: [
        Positioned.fill(
          child: _BlurredImageBg(url: _currentArtifact.imageUrl),
        ),
        Column(
          children: [
            SimpleHeader($strings.artifactsTitleArtifacts, showBackBtn: false, isTransparent: true),
            Gap($styles.insets.xs),
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
                Center(
                  child: SizedBox(
                    width: backdropWidth,
                    child: PageView.builder(
                      controller: _controller,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) => AnimatedBuilder(
                        animation: _controller,
                        builder: (_, __) {
                          bool isCurrentIndex = index % _artifacts.length == _currentIndex.value;
                          return ExcludeSemantics(
                            excluding: !isCurrentIndex,
                            child: _CarouselItem(
                              index: index,
                              currentPage: _currentOffset,
                              artifact: _artifacts[index % _artifacts.length],
                              bottomPadding: backdropHeight,
                              maxWidth: backdropWidth,
                              maxHeight: backdropHeight,
                              onPressed: () => _handleArtifactTap(index),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

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
                        _buildContent(context, backdropWidth, small),
                        Gap(small ? $styles.insets.sm : $styles.insets.md),
                        AppBtn.from(
                          text: $strings.artifactsButtonBrowse,
                          icon: Icons.search,
                          expand: true,
                          onPressed: _handleSearchTap,
                        ),
                        Gap(small ? $styles.insets.md : $styles.insets.lg),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, double width, bool small) {
    return Semantics(
      onIncrease: () => _handleArtifactTap(_currentOffset.round() + 1),
      onDecrease: () => _handleArtifactTap(_currentOffset.round() - 1),
      liveRegion: true,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IgnorePointer(
              ignoringSemantics: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: small ? 90 : 110,
                    alignment: Alignment.center,
                    child: StaticTextScale(
                      child: Text(
                        _currentArtifact.title,
                        overflow: TextOverflow.ellipsis,
                        style: $styles.text.h2.copyWith(color: $styles.colors.black, height: 1.2),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  if (!small) Gap($styles.insets.xxs),
                  Text(
                    _currentArtifact.date.isEmpty ? '--' : _currentArtifact.date,
                    style: $styles.text.body,
                    textAlign: TextAlign.center,
                  ),
                ],
              ).animate(key: ValueKey(_currentArtifact.artifactId)).fadeIn(),
            ),
            Gap(small ? $styles.insets.xs : $styles.insets.sm),
            AppPageIndicator(
              count: _artifacts.length,
              controller: _controller,
              semanticPageTitle: $strings.artifactsSemanticArtifact,
            ),
          ],
        ),
      ),
    );
  }
}
