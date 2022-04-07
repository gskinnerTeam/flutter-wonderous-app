import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/screens/artifact/artifact_highlights/artifact_blurred_bg.dart';
import 'dart:math' as math;

class ArtifactHighlightsScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactHighlightsScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactHighlightsScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactHighlightsScreen> {
  final _controller = PageController(initialPage: 0, viewportFraction: 0.8, keepPage: true);
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
        _currentPage = _controller.page ?? 0;
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

  @override
  Widget build(BuildContext context) {
    if (_currentArtifact == null) {
      return Center(child: AppLoader());
    }

    final pageView = PageView.builder(
      controller: _controller,
      onPageChanged: changeArtifactIndex,
      itemCount: _highlightedArtifactIds.length,
      itemBuilder: (context, index) {
        return FittedBox(
          child: CachedNetworkImage(
            // Show immediately; don't delay the appearance on the sides.
            fadeOutDuration: const Duration(milliseconds: 0),
            fadeInDuration: const Duration(milliseconds: 0),

            // Image URL ref.
            imageUrl: _loadedArtifacts[index % _loadedArtifacts.length].image,

            // Build the image previewer.
            imageBuilder: (context, imageProvider) {
              // TWEAKABLE: Setup some repeated parameters so it's easy to edit.
              // Scale of the elements, compared to max screen dimensions (maintains aspect ratio).
              double elementScale = 0.5;
              // Extra scale for the middle element.
              double elementScaleMidAdd = 0.1;
              // Height scale to make middle element like a capsule.
              double mainElementHeightScale = 0.4;
              // Vertical offset of the whole carousel.
              double vertOffset = 20;

              // Calculated variables.
              double elementWidth = 50;
              double offset = math.max(-2, math.min(2, _currentPage - double.parse(index.toString())));
              double mainElementScaleUp =
                  1 + (mainElementHeightScale - (math.min(1, offset.abs()) * mainElementHeightScale));

              double xAngle = math.asin((offset) * math.pi / 4.0);
              double yAngle = math.acos((offset.abs()) * math.pi / 4.0);

              // Transform object to animate pages.
              return Transform(
                origin: Offset(elementWidth / 2, (elementWidth / 2) * mainElementScaleUp),

                transform: Matrix4.identity()
                  ..translate(
                    xAngle * (elementWidth * 2.0 / 5.0),
                    yAngle * (-elementWidth * 2.0 / 5.0) + vertOffset,
                  )
                  ..scale((elementScale + elementScaleMidAdd) - (offset.abs() * elementScaleMidAdd)),

                // Inside the container, width and height determine aspect ratio
                child: Container(
                  width: elementWidth,
                  height: elementWidth * mainElementScaleUp,

                  // Round the edges, but make a capsule rather than a circle by only setting to width.
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(50)),

                    // Display image
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );

    return Container(
      color: context.colors.bg,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              child: ArtifactBlurredBg(url: _currentArtifact?.image ?? ''),
              duration: Duration(seconds: 1),
            ),
          ),
          // Big circle - part of the background
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.bg,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Header
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: context.insets.md),
              child: Text(
                'HIGHLIGHTS',
                style: context.textStyles.h3.copyWith(color: context.colors.bg, fontSize: 14),
              ),
            ),
          ),

          // Carousel
          Align(
            alignment: Alignment.center,
            child: FutureBuilder(
              future: Future.value(true),
              builder: (BuildContext context, AsyncSnapshot<void> snap) {
                return snap.hasData ? pageView : Container();
              },
            ),
          ),

          // Text and Artifact Search button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.insets.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Wonder Name
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      (_currentArtifact?.culture ?? '---').toUpperCase(),
                      style: context.textStyles.titleFont
                          .copyWith(color: context.colors.accent1, fontSize: 14, height: 1.2),
                    ),
                  ),

                  // Artifact Title
                  Padding(
                    padding: EdgeInsets.only(top: context.insets.md),
                    child: Text(
                      _currentArtifact?.title ?? '---',
                      style: context.textStyles.h2.copyWith(color: context.colors.greyStrong),
                    ),
                  ),

                  // Time frame
                  Padding(
                    padding: EdgeInsets.only(top: context.insets.xs),
                    child: Text(
                      _currentArtifact?.date ?? '---',
                      style: context.textStyles.body.copyWith(color: context.colors.body),
                    ),
                  ),

                  // Selection indicator
                  Padding(
                    padding: EdgeInsets.only(top: context.insets.lg),
                    child: SmoothPageIndicator(
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
                  ),

                  // Big ol' button
                  Padding(
                    padding: EdgeInsets.only(top: context.insets.xl, bottom: context.insets.xl),
                    child: GestureDetector(
                      onTap: () => context.push(ScreenPaths.search(widget.type)),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
