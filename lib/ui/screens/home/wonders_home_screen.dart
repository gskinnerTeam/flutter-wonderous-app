import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/buttons.dart';
import 'package:wonders/ui/screens/home/layers/machu_picchu.dart';
import 'package:wonders/ui/screens/home/layers/petra.dart';

/// PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style
class WondersHomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WondersHomeScreen({Key? key}) : super(key: key);

  @override
  State<WondersHomeScreen> createState() => _WondersHomeScreenState();
}

class _WondersHomeScreenState extends State<WondersHomeScreen> with GetItStateMixin {
  final _pageController = PageController(viewportFraction: 1);
  late int _wonderIndex = _pageController.initialPage;
  final _wonderLayerSets = [
    ParallaxLayerSet(bg: PetraBg(), mg: PetraMg(), fgBuilder: (v) => PetraFg(isShowing: v)),
    ParallaxLayerSet(bg: MachuPicchuBg(), mg: MachuPicchuMg(), fgBuilder: (v) => MachuPicchuFg(isShowing: v)),
    ParallaxLayerSet(bg: PetraBg(), mg: PetraMg(), fgBuilder: (v) => PetraFg(isShowing: v)),
    ParallaxLayerSet(bg: MachuPicchuBg(), mg: MachuPicchuMg(), fgBuilder: (v) => MachuPicchuFg(isShowing: v)),
    ParallaxLayerSet(bg: PetraBg(), mg: PetraMg(), fgBuilder: (v) => PetraFg(isShowing: v)),
    ParallaxLayerSet(bg: MachuPicchuBg(), mg: MachuPicchuMg(), fgBuilder: (v) => MachuPicchuFg(isShowing: v)),
    ParallaxLayerSet(bg: PetraBg(), mg: PetraMg(), fgBuilder: (v) => PetraFg(isShowing: v)),
    ParallaxLayerSet(bg: MachuPicchuBg(), mg: MachuPicchuMg(), fgBuilder: (v) => MachuPicchuFg(isShowing: v)),
  ];

  void _handlePageViewChanged(v) => setState(() => _wonderIndex = v);

  void _handleVerticalDrag(SwipeDirection dir) {
    if (dir == SwipeDirection.up) {
      _showDetailsPage();
    }
  }

  void _showDetailsPage() => context.push(ScreenPaths.wonderDetails(wonders.all.value[_wonderIndex].type));

  @override
  Widget build(BuildContext context) {
    /// Collect children for the various layers
    final bgChild = _wonderLayerSets[_wonderIndex].bg;
    final mgChildren = _wonderLayerSets.map((e) => e.mg).toList();
    final fgChildren = _wonderLayerSets.map((e) {
      bool isShowing = _wonderLayerSets.indexOf(e) == _wonderIndex;
      return e.fgBuilder(isShowing);
    }).toList();

    /// Layer children in a stack with bg on bottom and bg on top
    return SimpleGestureDetector(
      onVerticalSwipe: _handleVerticalDrag,
      swipeConfig: const SimpleSwipeConfig(verticalThreshold: 75),
      behavior: HitTestBehavior.translucent,
      child: Stack(children: [
        /// Bg
        Positioned.fill(
          child: AnimatedSwitcher(duration: context.style.times.fast, child: bgChild),
        ),

        /// Mg
        PageView(
          controller: _pageController,
          children: mgChildren,
          physics: BouncingScrollPhysics(),
          onPageChanged: _handlePageViewChanged,
        ),

        /// Fg
        BottomCenter(
          child: FractionallySizedBox(
            heightFactor: .4,
            widthFactor: 1,
            child: Stack(children: fgChildren),
          ),
        ),

        /// Floating controls / UI
        BottomCenter(
          child: AnimatedSwitcher(
            duration: context.style.times.fast,
            child: Column(
              key: ValueKey(_wonderIndex),
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(wonders.all.value[_wonderIndex].title, style: context.style.text.h1),
                Text('${_wonderIndex + 1}/${_wonderLayerSets.length}', style: context.style.text.h1),
                AppBtn(child: Icon(Icons.arrow_downward, size: 64), onPressed: _showDetailsPage),
                Gap(context.style.insets.lg),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

/// Represents a set of layers for a single wonder
class ParallaxLayerSet {
  ParallaxLayerSet({required this.bg, required this.mg, required this.fgBuilder});
  final Widget bg;
  final Widget mg;
  final Widget Function(bool isShowing) fgBuilder;
}

/// A shared API for all foreground layers that the [_FgStack] can use
abstract class HomeParallaxLayer extends StatelessWidget {
  const HomeParallaxLayer({Key? key, required this.isShowing}) : super(key: key);
  final bool isShowing;
}
