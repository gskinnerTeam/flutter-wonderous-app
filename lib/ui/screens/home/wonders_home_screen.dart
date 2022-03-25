import 'package:screenshot/screenshot.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/buttons.dart';
import 'package:wonders/ui/common/eight_way_swipe_detector.dart';
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
  final _screenshots = ScreenshotController();
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

  void _handleSwipe(Offset dir) {
    if (dir.dy == -1 && dir.dx == 0) _showDetailsPage();
  }

  void _showDetailsPage() => context.push(ScreenPaths.wonderDetails(wonders.all.value[_wonderIndex].type));

  void _handleSaveWallPaperPressed() async =>
      app.saveWallpaper(context, _wonderLayerSets[_wonderIndex].mg, name: 'wonder$_wonderIndex');

  void _handleSettingsPressed() => context.push(ScreenPaths.settings);

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
    return EightWaySwipeDetector(
      onSwipe: _handleSwipe,
      child: Stack(children: [
        /// Bg
        Positioned.fill(
          child: AnimatedSwitcher(duration: context.style.times.fast, child: bgChild),
        ),

        /// Mg
        Screenshot(
          controller: _screenshots,
          child: PageView(
            controller: _pageController,
            children: mgChildren,
            physics: BouncingScrollPhysics(),
            onPageChanged: _handlePageViewChanged,
          ),
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
        AnimatedSwitcher(
          duration: context.style.times.fast,
          child: Column(
            key: ValueKey(_wonderIndex),
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: double.infinity),
              Gap(context.insets.xl * 3),

              /// Save Background Btn
              AppBtn(child: Text('Save Background'), onPressed: _handleSaveWallPaperPressed),
              AppBtn(child: Text('Settings'), onPressed: _handleSettingsPressed),
              Spacer(),

              /// Title
              Text(wonders.all.value[_wonderIndex].title, style: context.style.text.h1),

              /// Page indicator
              Text('${_wonderIndex + 1}/${_wonderLayerSets.length}', style: context.style.text.h1),

              /// Down arrow
              AppBtn(child: Icon(Icons.arrow_downward, size: 64), onPressed: _showDetailsPage),
              Gap(context.style.insets.lg),
            ],
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
