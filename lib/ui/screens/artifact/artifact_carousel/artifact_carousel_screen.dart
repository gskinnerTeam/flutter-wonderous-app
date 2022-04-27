import 'dart:async';
import 'dart:math' as math;

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wonders/common_libs.dart';
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

  late final _highlightedArtifactIds = wondersLogic.getData(widget.type).highlightArtifacts;
  // Used to determine carousel element size.
  static const double _maxElementWidth = 500;
  // Used to determine white background dimensions.
  static const double _maxBottomHeight = 300;
  static const double _maxBottomWidth = 650;
  final _loadedArtifacts = [];
  late PageController _controller;
  HighlightsData? _currentArtifact;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _currentPage = _highlightedArtifactIds.length * 5000;
    _controller =
        PageController(initialPage: _currentPage.toInt(), viewportFraction: _pageViewportFraction, keepPage: true);
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0.0;
      });
    });

    _loadedArtifacts.clear();
    _loadedArtifacts.addAll(HighlightsData.forWonder(widget.type));

    if (_highlightedArtifactIds.isNotEmpty) {
      _changeArtifactIndex(0);
    } else {
      debugPrint('ERROR: No artifacts found for ${widget.type}');
    }

    // Update the screen.
    setState(() {});
  }

  @override
  void dispose() {
    // Ensure the contorller is disposed of properly.
    _controller.dispose();
    super.dispose();
  }

  void _changeArtifactIndex(int index) {
    //_controller.jumpToPage(index);
    setState(() {
      _currentArtifact = _loadedArtifacts[index % _highlightedArtifactIds.length];
    });
  }

  void _animatePageJump(int to) async {
    scheduleMicrotask(() {
      int ms = 300;
      _controller.animateToPage(to, duration: Duration(milliseconds: ms), curve: Curves.easeOut);
    });
  }

  void _handlePageJump(int jumpBy) {
    _animatePageJump(_controller.page!.round() + jumpBy);
  }

  void _handleArtifactTap(int index) =>
      context.push(ScreenPaths.artifact(_loadedArtifacts[index % _loadedArtifacts.length].artifactId.toString()));

  void _handleSearchButtonTap() => context.push(ScreenPaths.search(widget.type));

  @override
  Widget build(BuildContext context) {
    double carouselImageWidth = math.min(_maxElementWidth, context.widthPx / 1.25);
    double bottomHalfHeight = math.min(_maxBottomHeight, context.heightPx / 6);

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
            child:
                ArtifactCarouselBg(key: ValueKey(_currentArtifact?.artifactId), url: _currentArtifact?.imageUrl ?? ''),
            duration: Duration(milliseconds: 300),
          ),

          // White space, covering bottom half.
          BottomCenter(
            child: Container(
              width: math.min(context.widthPx, _maxBottomWidth),
              height: bottomHalfHeight + _maxBottomWidth / 2,
              decoration: BoxDecoration(
                color: context.colors.offWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_maxBottomWidth / 2), topRight: Radius.circular(_maxBottomWidth / 2)),
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

          // Prev tap button
          CenterLeft(
            child: BasicBtn(
              semanticLabel: 'previous',
              onPressed: () => _handlePageJump(-1),
              child: Container(width: 100, height: 500, color: Colors.transparent),
            ),
          ),

          // Next tap button
          CenterRight(
            child: BasicBtn(
              semanticLabel: 'next',
              onPressed: () => _handlePageJump(1),
              child: Container(width: 100, height: 500, color: Colors.transparent),
            ),
          ),

          // Text Content
          BottomCenter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.insets.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  Gap(context.insets.md),
                  Text(
                    'HIGHLIGHTS',
                    style: context.textStyles.h4.copyWith(color: context.colors.offWhite, fontSize: 14),
                  ),

                  // Carousel images
                  Gap(context.insets.md),
                  SizedBox(width: carouselImageWidth, height: carouselImageWidth * 0.75, child: pageViewArtifacts),

                  // Title and Desc
                  Gap(context.insets.md),
                  IgnorePointer(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Wonder Name
                        Text(
                          (_loadedArtifacts.isEmpty ? 'Just a moment...' : _currentArtifact?.culture ?? '')
                              .toUpperCase(),
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
                        // Selection indicator
                        _buildPageIndicator(context, _highlightedArtifactIds.length),
                      ],
                    ),
                  ),

                  // Big ol' button
                  Gap(context.insets.xl),
                  AppTextIconBtn(
                    'BROWSE ALL ARTIFACTS',
                    Icons.search,
                    expand: true,
                    padding: EdgeInsets.symmetric(vertical: context.insets.md),
                    onPressed: _handleSearchButtonTap,
                  ),
                  Gap(context.insets.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SmoothPageIndicator _buildPageIndicator(BuildContext context, int count) {
    return SmoothPageIndicator(
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
    );
  }
}
