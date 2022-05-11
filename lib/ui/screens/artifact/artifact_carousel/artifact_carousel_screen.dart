import 'dart:async';
import 'dart:math' as math;

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/highlights_data.dart';
import 'package:wonders/ui/common/app_page_indicator.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_bg.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_image.dart';

// TODO: GDS: refactor to match other views.

class ArtifactCarouselScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactCarouselScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactCarouselScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactCarouselScreen> {
  final _pageViewportFraction = 0.5;

  late final _wonderData = wondersLogic.getData(widget.type);
  late final _highlightedArtifactIds = wondersLogic.getData(widget.type).highlightArtifacts;
  // Used to cap white background dimensions.
  static const double _maxElementWidth = 375;
  static const double _maxElementHeight = 700;

  // Locally store loaded artifacts.
  final _loadedArtifacts = <HighlightsData>[];
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
      color: context.colors.greyStrong,
      child: Stack(
        children: [
          // Background Image
          AnimatedSwitcher(
            child: ArtifactCarouselBg(
              key: ValueKey(_currentArtifact?.artifactId),
              url: _currentArtifact?.imageUrl ?? '',
            ),
            duration: context.times.fast,
          ),

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
                  // White space, covering bottom half.
                  BottomCenter(
                    child: Container(
                      width: backdropWidth,
                      height: backdropHeight,
                      decoration: BoxDecoration(
                        color: context.colors.offWhite,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(backdropWidth),
                        ),
                      ),
                    ),
                  ),

                  // Gradient
                  BottomCenter(
                    child: VtGradient(
                      [Colors.transparent, context.colors.black.withOpacity(0.1)],
                      const [0, 1],
                      alignment: Alignment.topCenter,
                      height: context.insets.md,
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
                            return ArtifactCarouselImage(
                              index: index,
                              currentPage: _currentPage,
                              artifact: _loadedArtifacts[index % _loadedArtifacts.length],
                              viewportFraction: _pageViewportFraction,
                              bottomPadding: backdropHeight,
                              maxWidth: backdropWidth,
                              maxHeight: backdropHeight,
                              onPressed: () => _handleArtifactTap(index),
                            );
                          },
                        ),

                  // Prev tap button
                  CenterLeft(
                    child: GestureDetector(
                      onTap: () => _handlePageJump(-1),
                      child: Container(width: context.widthPx / 6, height: context.heightPx, color: Colors.transparent),
                    ),
                  ),

                  // Next tap button
                  CenterRight(
                    child: GestureDetector(
                      onTap: () => _handlePageJump(1),
                      child: Container(width: context.widthPx / 6, height: context.heightPx, color: Colors.transparent),
                    ),
                  ),

                  // Text content
                  BottomCenter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.insets.xl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap(context.insets.md),
                          // Text Content
                          _buildTextContent(context, backdropWidth, small),
                          // Selection indicator
                          AppPageIndicator(count: _highlightedArtifactIds.length, controller: _controller),
                          // Big ol' button
                          Gap(small ? context.insets.md : context.insets.xl),
                          _buildBrowseBtn(context, backdropWidth),
                          Gap(small ? context.insets.md : context.insets.lg),
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
        padding: EdgeInsets.symmetric(horizontal: context.insets.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Wonder Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Text(
                (_loadedArtifacts.isEmpty ? 'Just a moment...' : _currentArtifact?.culture ?? '').toUpperCase(),
                style: context.textStyles.titleFont.copyWith(
                  color: context.colors.accent1,
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
            Gap(context.insets.xxs),

            _loadedArtifacts.isEmpty
                ? AppLoader()
                : FXAnimate(
                    fx: const [FadeFX()],
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
                              style: context.textStyles.h2.copyWith(color: context.colors.greyStrong, height: 1.2),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Gap(context.insets.xxs),

                        // Time frame
                        Text(
                          _currentArtifact?.date ?? '',
                          style: context.textStyles.body.copyWith(color: context.colors.body),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

            Gap(small ? context.insets.sm : context.insets.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildBrowseBtn(BuildContext context, double width) {
    return SizedBox(
        width: width,
        child: AppTextIconBtn(
          'Browse all artifacts',
          Icons.search,
          expand: true,
          padding: EdgeInsets.symmetric(vertical: context.insets.sm),
          onPressed: _handleSearchButtonTap,
        ));
  }
}
