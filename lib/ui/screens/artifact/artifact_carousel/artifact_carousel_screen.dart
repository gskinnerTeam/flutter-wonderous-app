import 'dart:async';
import 'dart:math' as math;

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/highlights_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_bg.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_image.dart';

// TODO: GDS: look into why this is taking so long for the initial load.
// TODO: GDS: refactor to match other views.

class ArtifactCarouselScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactCarouselScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactCarouselScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactCarouselScreen> {
  final _pageViewportFraction = 0.5;
  final _bottomHeight = 300.0;

  late final _highlightedArtifactIds = wondersLogic.getData(widget.type).highlightArtifacts;
  // Used to determine carousel element size.
  static const double _maxElementWidth = 400;
  // Used to determine white background dimensions.
  static const double _maxBottomHeight = 300;
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

  void _handlePageChanged() {
    setState(() => _currentPage = _controller.page ?? 0.0);
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
    scheduleMicrotask(() {
      _controller.animateToPage(to, duration: context.times.fast, curve: Curves.easeOut);
    });
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
    final pageViewArtifacts = _loadedArtifacts.isEmpty
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
                bottomPadding: _bottomHeight + math.min(context.widthPx, _maxBottomHeight) / 2,
                onPressed: () => _handleArtifactTap(index),
              );
            },
          );

    return Container(
      color: context.colors.greyStrong,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          AnimatedSwitcher(
            child: ArtifactCarouselBg(
              key: ValueKey(_currentArtifact?.artifactId),
              url: _currentArtifact?.imageUrl ?? '',
            ),
            duration: context.times.fast,
          ),

          // White space, covering bottom half.
          BottomCenter(
            child: Container(
              width: math.min(context.widthPx, _maxElementWidth),
              height: _bottomHeight + math.min(context.widthPx, _maxBottomHeight) / 2,
              decoration: BoxDecoration(
                color: context.colors.offWhite,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(_maxElementWidth / 2),
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
          pageViewArtifacts,

          // Header
          TopCenter(
            child: Padding(
              padding: EdgeInsets.only(top: context.insets.lg),
              child: Text(
                'HIGHLIGHTS',
                style: context.textStyles.h4.copyWith(color: context.colors.offWhite, fontSize: 14),
              ),
            ),
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

          BottomCenter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.insets.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(context.insets.md),
                  // Text Content
                  _buildTextContent(),
                  // Selection indicator
                  _buildPageIndicator(context, _highlightedArtifactIds.length),
                  // Big ol' button
                  Gap(context.insets.xl),
                  _buildBrowseBtn(context),
                  Gap(context.insets.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppTextIconBtn _buildBrowseBtn(BuildContext context) {
    return AppTextIconBtn(
      'BROWSE ALL ARTIFACTS',
      Icons.search,
      expand: true,
      padding: EdgeInsets.symmetric(vertical: context.insets.md),
      onPressed: _handleSearchButtonTap,
    );
  }

  Widget _buildTextContent() {
    return IgnorePointer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Wonder Name
          Text(
            (_loadedArtifacts.isEmpty ? 'Just a moment...' : _currentArtifact?.culture ?? '').toUpperCase(),
            style: context.textStyles.titleFont.copyWith(
              color: context.colors.accent1,
              fontSize: 14,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          Gap(context.insets.md),

          _loadedArtifacts.isEmpty
              ? AppLoader()
              : FXAnimate(
                  fx: const [FadeFX()],
                  key: ValueKey(_currentArtifact?.artifactId),
                  child: Column(
                    children: [
                      // Artifact Title
                      Text(
                        _currentArtifact?.title ?? '',
                        style: context.textStyles.h2.copyWith(color: context.colors.greyStrong),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      Gap(context.insets.xs),

                      // Time frame
                      Text(
                        _currentArtifact?.date ?? '',
                        style: context.textStyles.body.copyWith(color: context.colors.body),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

          Gap(context.insets.lg),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(BuildContext context, int count) {
    return IgnorePointer(
      child: SmoothPageIndicator(
        controller: _controller,
        count: count,
        onDotClicked: _changeArtifactIndex,
        effect: ExpandingDotsEffect(
            dotWidth: 4,
            dotHeight: 4,
            paintStyle: PaintingStyle.fill,
            strokeWidth: 2,
            dotColor: context.colors.accent1,
            activeDotColor: context.colors.accent1,
            expansionFactor: 4),
      ),
    );
  }
}
