import 'dart:math' as math;
import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/highlight_data.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/controls/app_page_indicator.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/common/static_text_scale.dart';

part 'widgets/_blurred_image_bg.dart';
part 'widgets/_carousel_item.dart';

class GreyBox extends StatelessWidget {
  const GreyBox(this.lbl, {Key? key, this.strength = .5}) : super(key: key);
  final String lbl;
  final double strength;
  @override
  Widget build(BuildContext context) => ColoredBox(
        color: Colors.white,
        child: Container(
          color: Colors.grey.shade800.withOpacity(strength),
          child: Center(child: Text(lbl, style: $styles.text.h3)),
        ),
      );
}

class ArtifactCarouselScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactCarouselScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactCarouselScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactCarouselScreen> {
  PageController? _pageController;
  final _currentPage = ValueNotifier<double>(9999);

  late final List<HighlightData> _artifacts = HighlightData.forWonder(widget.type);
  late final _currentArtifactIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _handlePageChanged();
  }

  void _handlePageChanged() {
    _currentPage.value = _pageController?.page ?? 0;
    _currentArtifactIndex.value = _currentPage.value.round() % _artifacts.length;
  }

  @override
  Widget build(BuildContext context) {
    bool shortMode = context.heightPx < 800;
    final double bottomHeight = shortMode ? 190 : 310;
    // Allow objects to become wider as the screen becomes tall, this allows
    // them to grow taller as well, filling the available space better.
    //double itemWidth = 150 + max(context.heightPx - 600, 0) / 600 * 150;
    double itemHeight = context.heightPx - 150 - bottomHeight;
    double itemWidth = itemHeight * .666;
    // TODO: This could be optimized to only run if the size has changed...is it worth it?
    _pageController?.dispose();
    _pageController = PageController(
      viewportFraction: itemWidth / context.widthPx,
      initialPage: _currentPage.value.round(),
    );
    _pageController?.addListener(_handlePageChanged);
    final pages = [
      GreyBox('item1', strength: .5),
      GreyBox('item2', strength: .5),
      GreyBox('item3', strength: .5),
      GreyBox('item4', strength: .5),
      GreyBox('item5', strength: .5),
    ].map((e) => Padding(padding: EdgeInsets.all(10), child: e)).toList();

    return Stack(
      children: [
        /// Background
        Positioned.fill(
          child: ValueListenableBuilder<int>(
              valueListenable: _currentArtifactIndex,
              builder: (_, value, __) {
                return _BlurredImageBg(url: _artifacts[value].imageUrl);
              }),
        ),

        /// Bottom Text w/ Circle
        BottomCenter(
          child: ValueListenableBuilder<int>(
            valueListenable: _currentArtifactIndex,
            builder: (_, value, __) => _CarouselBottomTextWithCircle(
              artifact: _artifacts[value],
              height: bottomHeight,
              shortMode: shortMode,
              state: this,
            ),
          ),
        ),

        /// Carousel Items
        PageView.builder(
          controller: _pageController,
          itemBuilder: (_, index) {
            final child = pages[index % pages.length];
            return ValueListenableBuilder<double>(
              valueListenable: _currentPage,
              builder: (_, value, __) {
                final int offset = (value.round() - index).abs();
                return CollapsingCarouselListItem(
                  width: itemWidth,
                  bottom: bottomHeight,
                  indexOffset: min(3, offset),
                  child: child,
                );
              },
            );
          },
        ),

        /// header
        SimpleHeader(
          $strings.artifactsTitleArtifacts,
          showBackBtn: true,
          isTransparent: true,
          trailing: (context) => CircleBtn(
            semanticLabel: $strings.artifactsButtonBrowse,
            onPressed: () {},
            child: AppIcon(AppIcons.search),
          ),
        ),
      ],
    );
  }
}

/// Handles the carousel specific logic, like setting the height and vertical alignment of each item.
/// This lets the child simply render it's contents
class CollapsingCarouselListItem extends StatelessWidget {
  const CollapsingCarouselListItem(
      {Key? key, required this.child, required this.indexOffset, required this.width, required this.bottom})
      : super(key: key);
  final Widget child;
  final int indexOffset;
  final double width;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    // Calculate offset, this will be subtracted from the bottom padding moving the element downwards
    double vtOffset = indexOffset * 30;
    return AppBtn.basic(
      onPressed: () => print('todo'),
      semanticLabel: 'TODO',
      child: AnimatedOpacity(
        duration: $styles.times.fast,
        opacity: indexOffset.abs() <= 2 ? 1 : 0,
        child: AnimatedPadding(
          duration: $styles.times.fast,
          padding: EdgeInsets.only(bottom: bottom),
          child: BottomCenter(
            child: AnimatedContainer(
              duration: $styles.times.fast,
              // Center item is portrait, the others are square
              height: indexOffset == 0 ? width * 1.3 : width,
              child: Placeholder(),
            ),
          ),
        ),
      ),
    );
  }
}

class _CarouselBottomTextWithCircle extends StatelessWidget {
  const _CarouselBottomTextWithCircle(
      {Key? key, required this.artifact, required this.height, required this.state, required this.shortMode})
      : super(key: key);

  final HighlightData artifact;
  final double height;
  final _ArtifactScreenState state;
  final bool shortMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: $styles.sizes.maxContentWidth2,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
      alignment: Alignment.center,
      child: Stack(
        children: [
          /// BgCircle
          _buildBgCircle(),

          /// Text
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap($styles.insets.md),
              Column(
                children: [
                  IgnorePointer(
                    ignoringSemantics: false,
                    child: Semantics(
                      button: true,
                      // TODO: FIX
                      // onIncrease: () => _handleArtifactTap(_currentOffset.round() + 1),
                      // onDecrease: () => _handleArtifactTap(_currentOffset.round() - 1),
                      // onTap: () => _handleArtifactTap(_currentOffset.round()),
                      liveRegion: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Force column to stretch horizontally so text is centered
                          SizedBox(width: double.infinity),
                          // Stop text from scaling to make layout a little easier, it's already quite large
                          StaticTextScale(
                            child: Text(
                              artifact.title,
                              overflow: TextOverflow.ellipsis,
                              style: $styles.text.h2.copyWith(color: $styles.colors.black, height: 1.2, fontSize: 32),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                          if (!shortMode) ...[
                            Gap($styles.insets.xxs),
                            Text(
                              artifact.date.isEmpty ? '--' : artifact.date,
                              style: $styles.text.body,
                              textAlign: TextAlign.center,
                            ),
                          ]
                        ],
                      ).animate(key: ValueKey(artifact.artifactId)).fadeIn(),
                    ),
                  ),
                  Gap($styles.insets.sm),
                  if (!shortMode)
                    AppPageIndicator(
                      count: state._artifacts.length,
                      controller: state._pageController!,
                      semanticPageTitle: $strings.artifactsSemanticArtifact,
                    ),
                ],
              ),
              Gap($styles.insets.md),
              Spacer(),
              AppBtn.from(
                text: $strings.artifactsButtonBrowse,
                icon: AppIcons.search,
                expand: true,
                onPressed: () => _handleSearchTap(context),
              ),
              Gap($styles.insets.lg),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSearchTap(BuildContext context) {
    //context.push(ScreenPaths.search(widget.type));
  }

  OverflowBox _buildBgCircle() {
    return OverflowBox(
      maxWidth: 2000,
      maxHeight: 2000,
      child: Transform.translate(
        offset: Offset(0, 1000 - height * .7),
        child: Container(
          decoration: BoxDecoration(
            color: $styles.colors.offWhite.withOpacity(0.8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(999)),
          ),
        ),
      ),
    );
  }
}

class _ArtifactScreenState2 extends State<ArtifactCarouselScreen> {
  // Used to cap white background dimensions.
  static const double _maxElementWidth = 440;
  static const double _partialElementWidth = 0.9;
  static const double _maxElementHeight = 640;

  // Locally store loaded artifacts.
  late List<HighlightData> _artifacts;

  late PageController _controller;
  final _currentIndex = ValueNotifier(0);

  double get _currentOffset {
    bool hasOffset = _controller.hasClients && _controller.position.haveDimensions;
    return hasOffset ? _controller.page! : _controller.initialPage * 1.0;
  }

  HighlightData get _currentArtifact => _artifacts[_currentIndex.value];

  double get _backdropWidth {
    final w = context.widthPx;
    return w <= _maxElementWidth ? w : min(w * _partialElementWidth, _maxElementWidth);
  }

  double get _backdropHeight => math.min(context.heightPx * 0.65, _maxElementHeight);
  bool get _small => _backdropHeight / _maxElementHeight < 0.7;

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleCarouselScroll() => _currentIndex.value = _currentOffset.round() % _artifacts.length;

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
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, index, _) {
        return Container(
          color: $styles.colors.greyStrong,
          child: Stack(
            children: [
              /// Background image
              Positioned.fill(
                child: _BlurredImageBg(url: _currentArtifact.imageUrl),
              ),

              /// Content
              Column(
                children: [
                  SimpleHeader($strings.artifactsTitleArtifacts, showBackBtn: false, isTransparent: true),
                  Gap($styles.insets.xs),
                  Expanded(
                    child: Stack(children: [
                      // White arch, covering bottom half:
                      _buildWhiteArch(),

                      // Carousel
                      _buildCarouselPageView(),

                      // Text content
                      _buildBottomTextContent(),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWhiteArch() {
    return BottomCenter(
      child: Container(
        width: _backdropWidth,
        height: _backdropHeight,
        decoration: BoxDecoration(
          color: $styles.colors.offWhite.withOpacity(0.8),
          borderRadius: BorderRadius.vertical(top: Radius.circular(999)),
        ),
      ),
    );
  }

  Widget _buildBottomTextContent() {
    return BottomCenter(
      child: Container(
        width: _backdropWidth,
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap($styles.insets.md),
            Container(
              width: _backdropWidth,
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IgnorePointer(
                    ignoringSemantics: false,
                    child: Semantics(
                      button: true,
                      onIncrease: () => _handleArtifactTap(_currentOffset.round() + 1),
                      onDecrease: () => _handleArtifactTap(_currentOffset.round() - 1),
                      onTap: () => _handleArtifactTap(_currentOffset.round()),
                      liveRegion: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: _small ? 90 : 110,
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
                          if (!_small) Gap($styles.insets.xxs),
                          Text(
                            _currentArtifact.date.isEmpty ? '--' : _currentArtifact.date,
                            style: $styles.text.body,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ).animate(key: ValueKey(_currentArtifact.artifactId)).fadeIn(),
                    ),
                  ),
                  Gap(_small ? $styles.insets.xs : $styles.insets.sm),
                  AppPageIndicator(
                    count: _artifacts.length,
                    controller: _controller,
                    semanticPageTitle: $strings.artifactsSemanticArtifact,
                  ),
                ],
              ),
            ),
            Gap(_small ? $styles.insets.sm : $styles.insets.md),
            AppBtn.from(
              text: $strings.artifactsButtonBrowse,
              icon: AppIcons.search,
              expand: true,
              onPressed: _handleSearchTap,
            ),
            Gap(_small ? $styles.insets.md : $styles.insets.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselPageView() {
    return Center(
      child: SizedBox(
        width: _backdropWidth,
        child: ExcludeSemantics(
          child: PageView.builder(
            controller: _controller,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) => ListenableBuilder(
              listenable: _controller,
              builder: (_, __) {
                return _CarouselItem(
                  index: index,
                  currentPage: _currentOffset,
                  artifact: _artifacts[index % _artifacts.length],
                  bottomPadding: _backdropHeight,
                  maxWidth: _backdropWidth,
                  maxHeight: _backdropHeight,
                  onPressed: () => _handleArtifactTap(index),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
