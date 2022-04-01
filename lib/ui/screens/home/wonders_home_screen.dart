import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/wonders_controller.dart';
import 'package:wonders/ui/common/controls/buttons.dart';
import 'package:wonders/ui/common/controls/diagonal_page_indicator.dart';
import 'package:wonders/ui/common/controls/eight_way_swipe_detector.dart';
import 'package:wonders/ui/common/screen_scaffold.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_config.dart';

/// PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style
class WondersHomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WondersHomeScreen({Key? key}) : super(key: key);

  @override
  State<WondersHomeScreen> createState() => _WondersHomeScreenState();
}

//TODO @ AG - implement the remaining 6 home screens
class _WondersHomeScreenState extends State<WondersHomeScreen> with GetItStateMixin {
  final _pageController = PageController(viewportFraction: 1);
  late int _wonderIndex = _pageController.initialPage;

  void _handlePageViewChanged(v) => setState(() => _wonderIndex = v);

  void _handleSwipe(Offset dir) {
    if (dir.dy == -1 && dir.dx == 0) _showDetailsPage();
  }

  void _showDetailsPage() => context.push(ScreenPaths.wonderDetails(wonders.all.value[_wonderIndex].type));

  // TODO: FIX, add screen shot button, that uses off-screen widget to render
  // void _handleSaveWallPaperPressed() async {
  //   //  app.saveWallpaper(context, _wonderLayerSets[_wonderIndex].mg, name: 'wonder$_wonderIndex');
  // }

  void _handleSettingsPressed() => context.push(ScreenPaths.settings);

  @override
  Widget build(BuildContext context) {
    final wonders = watchX((WondersController w) => w.all);
    final currentWonder = wonders[_wonderIndex];
    bool isSelected(WonderType t) => t == wonders[_wonderIndex].type;

    /// Collect children for the various layers
    List<Widget> bgChildren = wonders.map((e) {
      final config = WonderIllustrationConfig.bg(isShowing: isSelected(e.type));
      return WonderIllustration(e.type, config: config);
    }).toList();

    List<Widget> mgChildren = wonders.map((e) {
      final config = WonderIllustrationConfig.mg(isShowing: isSelected(e.type));
      return WonderIllustration(e.type, config: config);
    }).toList();

    List<Widget> fgChildren = wonders.map((e) {
      final config = WonderIllustrationConfig.fg(isShowing: isSelected(e.type));
      return WonderIllustration(e.type, config: config);
    }).toList();

    /// Entire view is wrapped in a swipe detector to enable a down-swipe into the wonder details.
    return ScreenScaffold(
      isDark: true,
      enableSafeArea: false,
      child: EightWaySwipeDetector(
        onSwipe: _handleSwipe,

        /// Midground children will go in a PageView, sandwiched by Background and Foreground
        /// UI controls and a gradient will float on top
        child: Stack(children: [
          /// Sun / Clouds
          ...bgChildren,

          /// Wonder
          PageView(
            controller: _pageController,
            children: mgChildren,
            physics: BouncingScrollPhysics(),
            onPageChanged: _handlePageViewChanged,
          ),

          /// Foreground decorators
          ...fgChildren.map((e) => IgnorePointer(child: e)),

          /// Foreground gradient
          // TODO: How to get the foreground color for each gradient? Do we want to define this in AppColors?
          // TODO: Would be cool if this gradient got darker when pulling down...
          BottomCenter(
            child: _AnimatedGradient(context.colors.wonderBg(currentWonder.type)),
          ),

          /// Floating controls / UI
          AnimatedSwitcher(
            duration: context.style.times.fast,
            child: Column(
              key: ValueKey(_wonderIndex),
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: double.infinity),
                Gap(context.insets.lg * 3),

                /// Save Background Btn
                // AppBtn(child: Text('Save Background'), onPressed: _handleSaveWallPaperPressed),
                AppBtn(child: Text('Settings'), onPressed: _handleSettingsPressed),
                Spacer(),

                IgnorePointer(
                  child: Column(children: [
                    /// Page indicator
                    DiagonalPageIndicator(current: _wonderIndex + 1, total: wonders.length),
                    Gap(context.insets.md),

                    /// Title
                    SizedBox(
                      width: 350,
                      child: Text(
                        currentWonder.title.toUpperCase(),
                        style: context.style.text.h1.copyWith(height: 1),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                ),

                /// TODO: Add the page selector that expands upwards when you drag
                /// Down arrow
                AppBtn(
                    child: Icon(Icons.arrow_downward, size: 64, color: Theme.of(context).primaryColor),
                    onPressed: _showDetailsPage),
                Gap(context.style.insets.md),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class _AnimatedGradient extends StatelessWidget {
  _AnimatedGradient(this.fgColor, {Key? key}) : super(key: key);
  final Color fgColor;
  late final _gradientDec = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [fgColor.withOpacity(0), fgColor.withOpacity(.75)],
          stops: const [0, 1]));

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        height: context.heightPx * .6,
        child: AnimatedContainer(
          duration: context.times.med,
          decoration: _gradientDec,
        ),
      ),
    );
  }
}
