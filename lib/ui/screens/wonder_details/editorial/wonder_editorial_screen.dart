import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/utils/you_tube_utils.dart';
import 'package:wonders/ui/common/arch_clipper.dart';
import 'package:wonders/ui/common/controls/eight_way_swipe_detector.dart';
import 'package:wonders/ui/common/placeholder_image.dart';
import 'package:wonders/ui/common/placeholder_text.dart';
import 'package:wonders/ui/common/unsplash_photo.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_config.dart';

part 'editorial_title.dart';
part 'editorial_content.dart';
part 'editorial_illustration.dart';
part 'circular_title_bar.dart';
part 'collapsing_app_bar.dart';

class WonderEditorialScreen extends StatefulWidget {
  const WonderEditorialScreen(this.data, {Key? key}) : super(key: key);
  final WonderData data;

  @override
  State<WonderEditorialScreen> createState() => _WonderEditorialScreenState();
}

class _WonderEditorialScreenState extends State<WonderEditorialScreen> {
  late final ScrollController _scroller = ScrollController()..addListener(_handleScrollChanged);

  /// TODO: Make these final once design has stabilized
  double get _headerHeight => 330;
  double get _minAppBarHeight => 190;
  double get _maxAppBarHeight => 700;

  final _scrollPos = ValueNotifier(0.0);

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  /// Various [ValueListenableBuilders] are mapped to the _scrollPos and will rebuild when it changes
  void _handleScrollChanged() => _scrollPos.value = _scroller.position.pixels;

  /// Listen for up-swipe to go back to home
  void _handleListTopSwipe(Offset dir) {
    if (dir == Offset(0, 1)) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.wonderBg(widget.data.type),
      child: Stack(
        children: [
          /// Illustration - Sits underneath the scrolling content, fades out as it scrolls
          SizedBox(
            height: _headerHeight,
            child: ValueListenableBuilder<double>(
              valueListenable: _scrollPos,
              builder: (_, value, child) {
                // get some value between 0 and 1, based on the amt scrolled
                double opacity = max(0, 1 - value / 500);
                return Opacity(opacity: opacity, child: child);
              },
              child: _TopIllustration(widget.data.type),
            ),
          ),

          /// Scrolling content - Includes an invisible gap at the top, and then scrolls over the illustration
          CustomScrollView(
            primary: false,
            controller: _scroller,
            slivers: [
              /// Invisible padding at the top of the list, so the illustration shows through the btm
              SliverToBoxAdapter(
                child: EightWaySwipeDetector(
                  onSwipe: _handleListTopSwipe,
                  child: SizedBox(height: _headerHeight + context.insets.md),
                ),
              ),

              /// Text content, animates itself to hide behind the app bar as it scrolls up
              SliverToBoxAdapter(
                  child: ValueListenableBuilder<double>(
                      valueListenable: _scrollPos,
                      builder: (_, value, child) {
                        double offsetAmt = max(0, value * .3);
                        double opacity = max(0, 1 - offsetAmt / 150);
                        return Transform.translate(
                          offset: Offset(0, offsetAmt),
                          child: Opacity(opacity: opacity, child: child),
                        );
                      },
                      child: _TitleText(widget.data))),

              /// App bar
              SliverAppBar(
                pinned: true,
                collapsedHeight: _minAppBarHeight,
                expandedHeight: _maxAppBarHeight,
                backgroundColor: Colors.transparent,
                leading: SizedBox.shrink(),
                flexibleSpace: ValueListenableBuilder<double>(
                  valueListenable: _scrollPos,
                  builder: (_, value, child) {
                    double opacity = min(1, .4 + (value / 1000));
                    return Opacity(opacity: Curves.easeIn.transform(opacity), child: child);
                  },
                  child: SizedBox.expand(
                    child: _CollapsingAppBar(widget.data.type, imageId: 'VPavA7BBxK0'),
                  ),
                ),
                //ColoredBox(color: Colors.grey.shade200, child: Placeholder())
              ),

              /// Editorial content (text and images)
              SliverToBoxAdapter(
                child: _EditorialContent(widget.data),
              ),

              /// Bottom padding
              SliverToBoxAdapter(
                child: Container(height: 100, color: context.colors.bg),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
