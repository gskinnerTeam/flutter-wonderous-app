import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/screens/artifact/artifact_highlights/artifact_blurred_bg.dart';

class ArtifactHighlightsScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactHighlightsScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactHighlightsScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactHighlightsScreen> {
  final _controller = PageController(viewportFraction: 0.8, keepPage: true);
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

  @override
  void initState() {
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
    setState(() {
      _currentArtifact = _loadedArtifacts[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Needs rotating image carousel. Ref: https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframes?node-id=785%3A7621

    // Show:
    // - wonder name,
    // - artifact name,
    // - artifact date,
    // - bar to indicate which of 6 preloaded artifacts are shown
    // - Browse all button (links to ArtifactSearchScreen)
    // - App navigator bar on bottom

    final wonderData = wonders.getDataForType(widget.type);

    if (_currentArtifact == null) {
      return Center(child: AppLoader());
    }

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

          // Header
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Highlights',
              style: context.textStyles.h3.copyWith(color: context.colors.bg),
            ),
          ),

          // Carousel
          Placeholder(fallbackHeight: 400),

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
                      wonderData.title.toUpperCase(),
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
                      _currentArtifact?.period ?? '---',
                      style: context.textStyles.body.copyWith(color: context.colors.body),
                    ),
                  ),
                  // Selection indicator
                  Padding(
                    padding: EdgeInsets.only(top: context.insets.lg),
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 6,
                      effect: ExpandingDotsEffect(
                          dotWidth: 4,
                          dotHeight: 4,
                          paintStyle: PaintingStyle.stroke,
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
