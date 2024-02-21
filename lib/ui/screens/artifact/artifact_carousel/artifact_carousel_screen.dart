import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/highlight_data.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/controls/app_header.dart';
import 'package:wonders/ui/common/controls/app_page_indicator.dart';
import 'package:wonders/ui/common/static_text_scale.dart';

part 'widgets/_blurred_image_bg.dart';
part 'widgets/_bottom_text_content.dart';
part 'widgets/_collapsing_carousel_item.dart';

class ArtifactCarouselScreen extends StatefulWidget {
  const ArtifactCarouselScreen({super.key, required this.type, this.contentPadding = EdgeInsets.zero});
  final WonderType type;
  final EdgeInsets contentPadding;

  @override
  State<ArtifactCarouselScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactCarouselScreen> {
  PageController? _pageController;
  final _currentPage = ValueNotifier<double>(9999);

  late final List<HighlightData> _artifacts = HighlightData.forWonder(widget.type);
  late final _currentArtifactIndex = ValueNotifier<int>(_wrappedPageIndex);

  int get _wrappedPageIndex => _currentPage.value.round() % _artifacts.length;

  void _handlePageChanged() {
    _currentPage.value = _pageController?.page ?? 0;
    _currentArtifactIndex.value = _wrappedPageIndex;
  }

  void _handleSearchTap() => context.go(ScreenPaths.search(widget.type));

  void _handleArtifactTap(int index) {
    int delta = index - _currentPage.value.round();
    if (delta == 0) {
      HighlightData data = _artifacts[index % _artifacts.length];
      context.go(ScreenPaths.artifact(data.artifactId));
    } else {
      _pageController?.animateToPage(
        _currentPage.value.round() + delta,
        duration: $styles.times.fast,
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool shortMode = context.heightPx <= 800;
    final double bottomHeight = context.heightPx / 2.75; // Prev 340, dynamic seems to work better
    // Allow objects to become wider as the screen becomes tall, this allows
    // them to grow taller as well, filling the available space better.
    double itemHeight = (context.heightPx - 200 - bottomHeight).clamp(250, 400);
    double itemWidth = itemHeight * .666;
    // TODO: This could be optimized to only run if the size has changed...is it worth it?
    _pageController?.dispose();
    _pageController = PageController(
      viewportFraction: itemWidth / context.widthPx,
      initialPage: _currentPage.value.round(),
    );
    _pageController?.addListener(_handlePageChanged);
    final pages = _artifacts.map((e) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: _DoubleBorderImage(e),
      );
    }).toList();

    return Stack(
      children: [
        /// Blurred Bg
        Positioned.fill(
          child: ValueListenableBuilder<int>(
              valueListenable: _currentArtifactIndex,
              builder: (_, value, __) {
                return _BlurredImageBg(url: _artifacts[value].imageUrl);
              }),
        ),

        Padding(
            padding: widget.contentPadding,
            child: Stack(
              children: [
                /// BgCircle
                _buildBgCircle(bottomHeight),

                /// Carousel Items
                PageView.builder(
                  controller: _pageController,
                  itemBuilder: (_, index) {
                    final wrappedIndex = index % pages.length;
                    final child = pages[wrappedIndex];
                    return ValueListenableBuilder<double>(
                      valueListenable: _currentPage,
                      builder: (_, value, __) {
                        final int offset = (value.round() - index).abs();
                        return _CollapsingCarouselItem(
                          width: itemWidth,
                          indexOffset: min(3, offset),
                          onPressed: () => _handleArtifactTap(index),
                          title: _artifacts[wrappedIndex].title,
                          child: child,
                        );
                      },
                    );
                  },
                ),

                /// Bottom Text
                BottomCenter(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _currentArtifactIndex,
                    builder: (_, value, __) => _BottomTextContent(
                      artifact: _artifacts[value],
                      height: bottomHeight,
                      shortMode: shortMode,
                      state: this,
                    ),
                  ),
                ),

                /// Header
                AppHeader(
                  title: $strings.artifactsTitleArtifacts,
                  showBackBtn: false,
                  isTransparent: true,
                  trailing: (context) => CircleBtn(
                    semanticLabel: $strings.artifactsButtonBrowse,
                    onPressed: _handleSearchTap,
                    child: AppIcon(AppIcons.search),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  OverflowBox _buildBgCircle(double height) {
    const double size = 2000;
    return OverflowBox(
      maxWidth: size,
      maxHeight: size,
      child: Transform.translate(
        offset: Offset(0, size / 2),
        child: Container(
          decoration: BoxDecoration(
            color: $styles.colors.offWhite.withOpacity(0.8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(size)),
          ),
        ),
      ),
    );
  }
}
