import 'dart:async';
import 'dart:math' as math;

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/highlights_data.dart';
import 'package:wonders/ui/common/app_page_indicator.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_bg.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_image.dart';

// TODO: GDS: refactor to match other views.
// TODO: GDS: simplify

class ArtifactCarouselScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactCarouselScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactCarouselScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactCarouselScreen> {
  final _pageViewportFraction = 0.5;

  late final _highlightedArtifactIds = wondersLogic.getData(widget.type).highlightArtifacts;
  // Used to cap white background dimensions.
  static const double _maxElementWidth = 375;
  static const double _maxElementHeight = 700;

  // Locally store loaded artifacts.
  final List<HighlightsData> _loadedArtifacts = [];
  late PageController _controller;
  HighlightsData? _currentArtifact;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _currentPage = _highlightedArtifactIds.length * 5000;
    _controller = PageController(
      initialPage: _currentPage.toInt(),
      viewportFraction: _pageViewportFraction,
      keepPage: true,
    );
    _controller.addListener(_handlePageChanged);

    _loadedArtifacts.clear();
    _loadedArtifacts.addAll(HighlightsData.forWonder(widget.type));

    if (_highlightedArtifactIds.isNotEmpty) {
      _changeArtifactIndex(0);
    } else {
      debugPrint('ERROR: No artifacts found for ${widget.type}');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeArtifactIndex(int index) {
    setState(() {
      _currentArtifact = _loadedArtifacts[index % _highlightedArtifactIds.length];
    });
  }

  Future<void> _animatePageJump(int to) async {
    scheduleMicrotask(
        () => _controller.animateToPage(to, duration: Duration(milliseconds: 200), curve: Curves.easeOut));
  }

  void _handlePageChanged() {
    setState(() => _currentPage = _controller.page ?? 0.0);
  }

  void _handlePageJump(int jumpBy) {
    _animatePageJump(_controller.page!.round() + jumpBy);
  }

  void _handleArtifactTap(int index) {
    HighlightsData data = _loadedArtifacts[index % _loadedArtifacts.length];
    context.push(ScreenPaths.artifact(data.artifactId));
  }

  void _handleSearchButtonTap() => context.push(ScreenPaths.search(widget.type));

  @override
  Widget build(BuildContext context) {
    double backdropWidth = math.min(context.widthPx, _maxElementWidth);
    double backdropHeight = math.min(context.heightPx * 0.65, _maxElementHeight);

    bool small = backdropHeight / _maxElementHeight < .8;

    return Container(
      color: $styles.colors.greyStrong,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(child: ArtifactCarouselBg(url: _currentArtifact?.imageUrl)),

          // Header
          Column(children: [
            SimpleHeader(
              'ARTIFACTS',
              showBackBtn: false,
              isTransparent: true,
            ),
            Expanded(
              child: Stack(
                children: [
                  // White arch, covering bottom half.
                  BottomCenter(
                    child: Container(
                      width: backdropWidth,
                      height: backdropHeight,
                      decoration: BoxDecoration(
                        color: $styles.colors.offWhite.withOpacity(0.8),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(999),
                        ),
                      ),
                    ),
                  ),

                  // Carousel images
                  _loadedArtifacts.isEmpty
                      ? Container()
                      : PageView.builder(
                          controller: _controller,
                          itemCount: _highlightedArtifactIds.length * 10000,
                          clipBehavior: Clip.none,
                          onPageChanged: _changeArtifactIndex,
                          itemBuilder: (context, index) {
                            return ExcludeSemantics(
                              excluding: index != _currentPage.round(),
                              child: ArtifactCarouselImage(
                                index: index,
                                currentPage: _currentPage,
                                artifact: _loadedArtifacts[index % _loadedArtifacts.length],
                                viewportFraction: _pageViewportFraction,
                                bottomPadding: backdropHeight,
                                maxWidth: backdropWidth,
                                maxHeight: backdropHeight,
                                onPressed: () => _handleArtifactTap(index),
                              ),
                            );
                          },
                        ),

                  // Prev tap button
                  CenterLeft(
                    child: AppBtn.basic(
                      semanticLabel: 'Previous artifact',
                      onPressed: () => _handlePageJump(-1),
                      child: Container(width: context.widthPx / 6, height: context.heightPx, color: Colors.transparent),
                    ),
                  ),

                  // Next tap button
                  CenterRight(
                    child: AppBtn.basic(
                      semanticLabel: 'Next artifact',
                      onPressed: () => _handlePageJump(1),
                      child: Container(width: context.widthPx / 6, height: context.heightPx, color: Colors.transparent),
                    ),
                  ),

                  // Text content
                  BottomCenter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: $styles.insets.xl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap($styles.insets.md),
                          // Text Content
                          _buildTextContent(context, backdropWidth, small),
                          // Selection indicator
                          AppPageIndicator(
                            count: _highlightedArtifactIds.length,
                            controller: _controller,
                            semanticPageTitle: 'artifact',
                          ),
                          // Big ol' button
                          Gap(small ? $styles.insets.md : $styles.insets.xl),
                          _buildBrowseBtn(context),
                          Gap(small ? $styles.insets.md : $styles.insets.lg),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, double width, bool small) {
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
                (_loadedArtifacts.isEmpty ? 'Just a moment...' : _currentArtifact?.culture ?? '').toUpperCase(),
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
            // Note; title's line height is 14px more than its size,
            // so adding that to the gap should be padding enough.
            Gap($styles.insets.xxs),

            _loadedArtifacts.isEmpty
                ? AppLoader()
                : Animate(
                    effects: const [FadeEffect()],
                    key: ValueKey(_currentArtifact?.artifactId),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Artifact Title
                        SizedBox(
                          height: small ? 84 : 92,
                          child: Center(
                            child: Text(
                              (_currentArtifact?.title ?? ''),
                              overflow: TextOverflow.ellipsis,
                              style: $styles.text.h2.copyWith(color: $styles.colors.black, height: 1.2),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Gap($styles.insets.xxs),

                        // Time frame
                        Text(
                          _currentArtifact?.date ?? '',
                          style: $styles.text.body.copyWith(color: $styles.colors.greyStrong),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

            Gap(small ? $styles.insets.sm : $styles.insets.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildBrowseBtn(BuildContext context) {
    return AppBtn.from(
      text: 'Browse all artifacts',
      icon: Icons.search,
      expand: true,
      onPressed: _handleSearchButtonTap,
    );
  }
}
