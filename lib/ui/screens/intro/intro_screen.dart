import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/controls/app_page_indicator.dart';
import 'package:wonders/ui/common/stacked_page_view_builder.dart';
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
  static const double _textHeight = 120;

  static List<_PageData> pageData = [
    _PageData($strings.introTitleJourney, $strings.introDescriptionNavigate, 'camel', '1'),
    _PageData($strings.introTitleExplore, $strings.introDescriptionUncover, 'petra', '2'),
    _PageData($strings.introTitleDiscover, $strings.introDescriptionLearn, 'statue', '3'),
  ];

  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  void _handleIntroCompletePressed() {
    context.go(ScreenPaths.home);
    settingsLogic.hasCompletedOnboarding.value = true;
  }

  void _handlePageChanged(PageController controller) {
    int newPage = controller.page?.round() ?? 0;
    _currentPage.value = newPage;
  }

  void _handleSemanticSwipe(int dir, PageController controller) {
    controller.animateToPage((controller.page ?? 0).round() + dir, duration: $styles.times.fast, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = LayoutBuilder(builder: (context, constraints) {
      /// This view uses a [StackedPageViewBuilder] to enable swipe navigation on the entire view, while
      /// keeping the content of the PageView to a discrete portion of the UI. This makes layout easier and works better with screen-readers.
      return StackedPageViewBuilder(
          pageCount: pageData.length,
          onInit: (controller, follower) => follower.addListener(() => _handlePageChanged(follower)),
          builder: (context, controller, follower) {
            final List<Widget> pages = pageData.map((e) {
              return _Page(data: e, imageHeight: _imageSize);
            }).toList();
            return Stack(
              children: [
                IgnorePointer(
                  ignoringSemantics: false,
                  child: Column(
                    children: [
                      Spacer(),

                      // logo:
                      Semantics(
                        header: true,
                        container: true,
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

                      Gap($styles.insets.sm),

                      // page view with title & description:
                      SizedBox(
                        height: _textHeight,
                        width: _imageSize * 1.15,
                        child: MergeSemantics(
                          child: Semantics(
                            liveRegion: true,
                            onIncrease: () => _handleSemanticSwipe(1, controller),
                            onDecrease: () => _handleSemanticSwipe(-1, controller),
                            child: PageView(
                              controller: follower,
                              children: pages,
                              onPageChanged: (_) => AppHaptics.lightImpact(),
                            ),
                          ),
                        ),
                      ),

                      // page indicator:
                      AppPageIndicator(
                        count: pageData.length,
                        controller: follower,
                        color: $styles.colors.offWhite,
                      ),

                      Spacer(flex: 2),
                    ],
                  ),
                ),

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
                    child: _buildNavText(context, follower),
                  ),
                ),
              ],
            );
          });
    });

    return LightText(
      child: Container(
        color: $styles.colors.black,
        child: SafeArea(child: content.animate().fadeIn(delay: 500.ms)),
      ),
    );
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

  Widget _buildNavText(BuildContext context, PageController controller) {
    return ValueListenableBuilder(
      valueListenable: _currentPage,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == pageData.length - 1 ? 0 : 1,
          duration: $styles.times.fast,
          child: Semantics(
            onTapHint: $strings.introSemanticNavigate,
            onTap: () {
              final int current = controller.page!.round();
              controller.animateToPage(current + 1, duration: 250.ms, curve: Curves.easeIn);
            },
            child: IgnorePointer(
              ignoringSemantics: false,
              child: Text($strings.introSemanticSwipeLeft, style: $styles.text.bodySmall),
            ),
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
  const _Page({Key? key, required this.data, required this.imageHeight}) : super(key: key);

  final double imageHeight;
  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(data.title, textAlign: TextAlign.center, style: $styles.text.wonderTitle.copyWith(fontSize: 24)),
        Gap($styles.insets.sm),
        Text(data.desc, style: $styles.text.body, textAlign: TextAlign.center),
      ],
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
        Text(
          $strings.introSemanticWonderous,
          style: $styles.text.wonderTitle.copyWith(fontSize: 32, color: $styles.colors.offWhite),
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
          ),
        ),
      ],
    );
  }
}
