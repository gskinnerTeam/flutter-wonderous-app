import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/screens/artifact/artifact_highlights/artifact_blurred_bg.dart';
import 'package:wonders/ui/screens/artifact/artifact_highlights/artifact_image_page.dart';

class ArtifactHighlightsScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactHighlightsScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactHighlightsScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactHighlightsScreen> {
  final _controller = PageController(initialPage: 0, viewportFraction: 0.4, keepPage: true);
  final _highlightedArtifactIds = [
    '503940',
    '312595',
    '310551',
    '316304',
    '313151',
    '313256',
  ];
  final _loadedArtifacts = [];
  ArtifactData? _currentArtifact;
  double _currentPage = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0.0;
      });
    });

    super.initState();

    getHighlightedArtifacts();
  }

  void getHighlightedArtifacts() async {
    for (var id in _highlightedArtifactIds) {
      _loadedArtifacts.add(await search.getArtifactByID(id));
    }

    changeArtifactIndex(0);
  }

  void changeArtifactIndex(int index) {
    //_controller.jumpToPage(index);
    setState(() {
      _currentArtifact = _loadedArtifacts[index % _highlightedArtifactIds.length];
    });
  }

  void handleArtifactTap(int index) =>
      context.push(ScreenPaths.artifact(_loadedArtifacts[index % _loadedArtifacts.length].objectId.toString()));

  void handleSearchButtonTap() => context.push(ScreenPaths.search(widget.type));

  @override
  Widget build(BuildContext context) {
    double bottomHalfHeight = 300;

    if (_currentArtifact == null) {
      return Center(child: AppLoader());
    }

    final pageViewArtifacts = PageView.builder(
      controller: _controller,
      onPageChanged: changeArtifactIndex,
      itemCount: _highlightedArtifactIds.length,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return ArtifactImagePage(
          index: index,
          currentPage: _currentPage,
          artifact: _loadedArtifacts[index % _loadedArtifacts.length],
          onClick: handleArtifactTap,
        );
      },
    );

    return Container(
      color: context.colors.greyStrong,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          TopCenter(
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    child: ArtifactBlurredBg(
                        key: ValueKey(_currentArtifact?.objectId), url: _currentArtifact?.image ?? ''),
                    duration: Duration(milliseconds: 300),
                  ),
                ),
              ],
            ),
          ),

          // Big circle - part of the background
          Positioned(
            bottom: bottomHalfHeight - (context.widthPx / 2),
            left: 0,
            right: 0,
            child: Container(
              height: context.widthPx,
              decoration: BoxDecoration(
                color: context.colors.bg,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // White space, covering bottom half.
          BottomCenter(
            child: Container(height: bottomHalfHeight, color: context.colors.bg),
          ),

          // Carousel images
          BottomCenter(
            heightFactor: 0.5,
            child: FutureBuilder(
              future: Future.value(true),
              builder: (BuildContext context, AsyncSnapshot<void> snap) {
                return snap.hasData ? pageViewArtifacts : Container();
              },
            ),
          ),

          // Header
          TopCenter(
            child: Padding(
              padding: EdgeInsets.only(top: context.insets.md),
              child: Text(
                'HIGHLIGHTS',
                style: context.textStyles.h3.copyWith(color: context.colors.bg, fontSize: 14),
              ),
            ),
          ),

          // Text and Artifact Search button
          BottomCenter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.insets.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Wonder Name
                      Text(
                        (_currentArtifact?.culture ?? '---').toUpperCase(),
                        style: context.textStyles.titleFont
                            .copyWith(color: context.colors.accent1, fontSize: 14, height: 1.2),
                      ),
                      Gap(context.insets.md),

                      // Artifact Title
                      Text(
                        _currentArtifact?.title ?? '---',
                        style: context.textStyles.h2.copyWith(color: context.colors.greyStrong),
                      ),
                      Gap(context.insets.xs),

                      // Time frame
                      Text(
                        _currentArtifact?.date ?? '---',
                        style: context.textStyles.body.copyWith(color: context.colors.body),
                      ),
                      Gap(context.insets.lg),
                    ],
                  ).gTweener.fade().withKey(ValueKey(_currentArtifact?.objectId)),

                  // Selection indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 6,
                    onDotClicked: changeArtifactIndex,
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
                  GestureDetector(
                    onTap: handleSearchButtonTap,
                    child: Container(
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
                                style: context.textStyles.body
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

                  Gap(context.insets.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
