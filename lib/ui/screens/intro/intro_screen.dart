import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/controls/app_page_indicator.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/static_text_scale.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/common/utils/app_haptics.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static const double _imageSize = 264;
  static const double _logoHeight = 126;
  static const double _textHeight = 155;
  static const double _pageIndicatorHeight = 55;

  static List<_PageData> pageData = [];

  late final PageController _pageController = PageController()..addListener(_handlePageChanged);
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleIntroCompletePressed() {
    if (_currentPage.value == pageData.length - 1) {
      context.go(ScreenPaths.home);
      settingsLogic.hasCompletedOnboarding.value = true;
    }
  }

  void _handlePageChanged() {
    int newPage = _pageController.page?.round() ?? 0;
    _currentPage.value = newPage;
  }

  void _handleSemanticSwipe(int dir) {
    _pageController.animateToPage((_pageController.page ?? 0).round() + dir,
        duration: $styles.times.fast, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    // Set the page data, as strings may have changed based on locale
    pageData = [
      _PageData($strings.introTitleJourney, $strings.introDescriptionNavigate, 'camel', '1'),
      _PageData($strings.introTitleExplore, $strings.introDescriptionUncover, 'petra', '2'),
      _PageData($strings.introTitleDiscover, $strings.introDescriptionLearn, 'statue', '3'),
    ];

    // This view uses a full screen PageView to enable swipe navigation.
    // However, we only want the title / description to actually swipe,
    // so we stack a PageView with that content over top of all the other
    // content, and line up their layouts.

    final List<Widget> pages = pageData.map((e) => _Page(data: e)).toList();

    final Widget content = Stack(children: [
      // page view with title & description:
      MergeSemantics(
        child: Semantics(
          onIncrease: () => _handleSemanticSwipe(1),
          onDecrease: () => _handleSemanticSwipe(-1),
          child: PageView(
            controller: _pageController,
            children: pages,
            onPageChanged: (_) => AppHaptics.lightImpact(),
          ),
        ),
      ),

      IgnorePointer(
        ignoringSemantics: false,
        child: Column(children: [
          Spacer(),

          // logo:
          Semantics(
            header: true,
            child: Container(
              height: _logoHeight,
              alignment: Alignment.center,
              child: _WonderousLogo(),
            ),
          ),

          // masked image:
          SizedBox(
            height: _imageSize,
            width: _imageSize,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: $styles.times.slow,
                  child: KeyedSubtree(
                    key: ValueKey(value), // so AnimatedSwitcher sees it as a different child.
                    child: _PageImage(data: pageData[value]),
                  ),
                );
              },
            ),
          ),

          // placeholder gap for text:
          Gap(_IntroScreenState._textHeight),

          // page indicator:
          Container(
            height: _pageIndicatorHeight,
            alignment: Alignment(0.0, -0.75),
            child:
                AppPageIndicator(count: pageData.length, controller: _pageController, color: $styles.colors.offWhite),
          ),

          Spacer(flex: 2),
        ]),
      ),

      // Build a cpl overlays to hide the content when swiping on very wide screens
      _buildHzGradientOverlay(left: true),
      _buildHzGradientOverlay(),

      // finish button:
      Positioned(
        right: $styles.insets.lg,
        bottom: $styles.insets.lg,
        child: _buildFinishBtn(context),
      ),

      // nav help text:
      BottomCenter(
        child: Padding(
          padding: EdgeInsets.only(bottom: $styles.insets.lg),
          child: _buildNavText(context),
        ),
      ),
    ]);

    return DefaultTextColor(
      color: $styles.colors.offWhite,
      child: Container(
        color: $styles.colors.black,
        child: SafeArea(child: content.animate().fadeIn(delay: 500.ms)),
      ),
    );
  }

  Widget _buildHzGradientOverlay({bool left = false}) {
    return Align(
      alignment: Alignment(left ? -1 : 1, 0),
      child: FractionallySizedBox(
        widthFactor: .5,
        child: Padding(
          padding: EdgeInsets.only(left: left ? 0 : 200, right: left ? 200 : 0),
          child: Transform.scale(
              scaleX: left ? -1 : 1,
              child: HzGradient([
                $styles.colors.black.withOpacity(0),
                $styles.colors.black,
              ], const [
                0,
                .2
              ])),
        ),
      ),
    );
    // CenterLeft(
    // child: FractionallySizedBox(
    // widthFactor: .5,
    // child: Padding(
    // padding: const EdgeInsets.only(right: 200),
    // child: HzGradient([$styles.colors.black, $styles.colors.black.withOpacity(0)], const [.8, 1]),
    // ),
    // ),
    // );
  }

  Widget _buildFinishBtn(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPage,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == pageData.length - 1 ? 1 : 0,
          duration: $styles.times.fast,
          child: CircleIconBtn(
            icon: AppIcons.next_large,
            bgColor: $styles.colors.accent1,
            onPressed: _handleIntroCompletePressed,
            semanticLabel: $strings.introSemanticEnterApp,
          ),
        );
      },
    );
  }

  Widget _buildNavText(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _currentPage,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == pageData.length - 1 ? 0 : 1,
          duration: $styles.times.fast,
          child: Semantics(
            onTapHint: $strings.introSemanticNavigate,
            onTap: () {
              final int current = _pageController.page!.round();
              _pageController.animateToPage(current + 1, duration: 250.ms, curve: Curves.easeIn);
            },
            child: Text($strings.introSemanticSwipeLeft, style: $styles.text.bodySmall),
          ),
        );
      },
    );
  }
}

@immutable
class _PageData {
  const _PageData(this.title, this.desc, this.img, this.mask);

  final String title;
  final String desc;
  final String img;
  final String mask;
}

class _Page extends StatelessWidget {
  const _Page({Key? key, required this.data}) : super(key: key);

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Column(children: [
        Spacer(),
        Gap(_IntroScreenState._imageSize + _IntroScreenState._logoHeight),
        SizedBox(
          height: _IntroScreenState._textHeight,
          width: _IntroScreenState._imageSize + $styles.insets.md,
          child: StaticTextScale(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data.title, style: $styles.text.wonderTitle.copyWith(fontSize: 24 * $styles.scale)),
                Gap($styles.insets.sm),
                Text(data.desc, style: $styles.text.body, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        Gap(_IntroScreenState._pageIndicatorHeight),
        Spacer(flex: 2),
      ]),
    );
  }
}

class _WonderousLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExcludeSemantics(
          child: SvgPicture.asset(SvgPaths.compassSimple, color: $styles.colors.offWhite, height: 48),
        ),
        Gap($styles.insets.xs),
        StaticTextScale(
          child: Text(
            $strings.introSemanticWonderous,
            style: $styles.text.wonderTitle.copyWith(fontSize: 32 * $styles.scale, color: $styles.colors.offWhite),
          ),
        )
      ],
    );
  }
}

class _PageImage extends StatelessWidget {
  const _PageImage({Key? key, required this.data}) : super(key: key);

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            '${ImagePaths.common}/intro-${data.img}.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
          ),
        ),
        Positioned.fill(
            child: Image.asset(
          '${ImagePaths.common}/intro-mask-${data.mask}.png',
          fit: BoxFit.fill,
        )),
      ],
    );
  }
}
