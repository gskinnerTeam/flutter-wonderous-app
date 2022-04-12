import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_bg.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_image.dart';
import 'dart:math' as math;

class ArtifactCarouselScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactCarouselScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactCarouselScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactCarouselScreen> {
  final _pageViewportFraction = 0.5;
  final _highlightedArtifactIds = [
    '503940',
    '312595',
    '310551',
    '316304',
    '313151',
    '313256',
  ];
  final _loadedArtifacts = [];
  late PageController _controller;
  ArtifactData? _currentArtifact;
  double _currentPage = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0, viewportFraction: _pageViewportFraction, keepPage: true);
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0.0;
      });
    });

    super.initState();

    _getHighlightedArtifacts();
  }

  void _getHighlightedArtifacts() async {
    for (var id in _highlightedArtifactIds) {
      _loadedArtifacts.add(await searchLogic.getArtifactByID(id));
    }

    _changeArtifactIndex(0);
  }

  void _changeArtifactIndex(int index) {
    //_controller.jumpToPage(index);
    setState(() {
      _currentArtifact = _loadedArtifacts[index % _highlightedArtifactIds.length];
    });
  }

  void _handleArtifactTap(int index) =>
      context.push(ScreenPaths.artifact(_loadedArtifacts[index % _loadedArtifacts.length].objectId.toString()));

  void _handleSearchButtonTap() => context.push(ScreenPaths.search(widget.type));

  @override
  Widget build(BuildContext context) {
    // Used to determine carousel element size.
    double maxElementWidth = 500;
    double carouselImageWidth = math.min(maxElementWidth, context.widthPx / 1.25);

    // Used to determine white background dimensions.
    double maxBottomHeight = 300;
    double bottomHalfHeight = math.min(maxBottomHeight, context.heightPx / 6);
    double maxBottomWidth = 650;

    if (_currentArtifact == null) {
      return Center(child: AppLoader());
    }

    final pageViewArtifacts = PageView.builder(
      controller: _controller,
      onPageChanged: _changeArtifactIndex,
      itemCount: _highlightedArtifactIds.length,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return ArtifactCarouselImage(
          index: index,
          currentPage: _currentPage,
          artifact: _loadedArtifacts[index % _loadedArtifacts.length],
          viewportFraction: _pageViewportFraction,
          onClick: _handleArtifactTap,
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
            child: ArtifactCarouselBg(key: ValueKey(_currentArtifact?.objectId), url: _currentArtifact?.image ?? ''),
            duration: Duration(milliseconds: 300),
          ),

          // White space, covering bottom half.
          BottomCenter(
            child: Container(
              width: math.min(context.widthPx, maxBottomWidth),
              height: bottomHalfHeight + maxBottomWidth / 2,
              decoration: BoxDecoration(
                color: context.colors.bg,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(maxBottomWidth / 2), topRight: Radius.circular(maxBottomWidth / 2)),
              ),
            ),
          ),

          // Content
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
                    style: context.textStyles.h3.copyWith(color: context.colors.bg, fontSize: 14),
                  ),

                  // Carousel images
                  Gap(context.insets.md),
                  FutureBuilder(
                    future: Future.value(true),
                    builder: (BuildContext context, AsyncSnapshot<void> snap) {
                      return snap.hasData
                          ? SizedBox(
                              width: carouselImageWidth, height: carouselImageWidth * 0.75, child: pageViewArtifacts)
                          : Container();
                    },
                  ),

                  // Text and stuff
                  Gap(context.insets.md),
                  IgnorePointer(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Wonder Name
                        Text(
                          (_currentArtifact?.culture ?? '---').toUpperCase(),
                          style: context.textStyles.titleFont
                              .copyWith(color: context.colors.accent1, fontSize: 14, height: 1.2),
                          textAlign: TextAlign.center,
                        ),
                        Gap(context.insets.md),

                        // Artifact Title
                        Text(
                          _currentArtifact?.title ?? '---',
                          style: context.textStyles.h2.copyWith(color: context.colors.greyStrong),
                          textAlign: TextAlign.center,
                        ),
                        Gap(context.insets.xs),

                        // Time frame
                        Text(
                          _currentArtifact?.date ?? '---',
                          style: context.textStyles.body1.copyWith(color: context.colors.body),
                          textAlign: TextAlign.center,
                        ),
                        Gap(context.insets.lg),
                      ],
                    ).gTweener.fade().withKey(ValueKey(_currentArtifact?.objectId)),
                  ),

                  // Selection indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 6,
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

                  Gap(context.insets.xl),

                  // Big ol' button
                  // TODO: Make primary btn
                  GestureDetector(
                    onTap: _handleSearchButtonTap,
                    child: Container(
                      width: maxElementWidth - context.insets.md * 2,
                      decoration: BoxDecoration(
                        color: context.colors.greyStrong,
                        borderRadius: BorderRadius.all(Radius.circular(context.corners.md)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: context.insets.sm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('BROWSE ALL ARTIFACTS',
                                style: context.textStyles.body1
                                    .copyWith(color: context.colors.bg, fontSize: 12, height: 1.2)),
                            Padding(
                              padding: EdgeInsets.only(left: context.insets.xs),
                              child: Icon(Icons.search, color: context.colors.bg, size: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Gap(context.insets.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
