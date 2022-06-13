import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_page_indicator.dart';
import 'package:wonders/ui/common/themed_text.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static const double _imageHeight = 264;
  late final PageController _pageController = PageController()..addListener(_handlePageChanged);
  final _currentPage = ValueNotifier(0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleIntroCompletePressed() {
    context.go(ScreenPaths.home);
    settingsLogic.hasCompletedOnboarding.value = true;
  }

  void _handlePageChanged() {
    int newPage = _pageController.page?.round() ?? 0;
    _currentPage.value = newPage;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextColor(
      color: $styles.colors.offWhite,
      child: Container(
        padding: EdgeInsets.all($styles.insets.xxl),
        color: $styles.colors.black,
        child: Column(
          children: [
            Spacer(),

            /// Logo
            _WonderousLogo(),
            Gap($styles.insets.sm),

            /// Text + Image
            /// Set in a stack with a PageView on the bottom, and a masked image on top.
            /// Each page in the PageView has an empty gap at the top, which lines up with the masked image.
            /// The masked image cross fades as pages are changed.
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  child: PageView(
                    controller: _pageController,
                    children: const [
                      _Page(
                        title: 'Journey to the past',
                        desc: 'Navigate the intersection of time, art, and culture.',
                      ),
                      _Page(
                        title: 'Explore places',
                        desc: 'Uncover remarkable human-made structures from around the world',
                      ),
                      _Page(
                        title: 'Discover artifacts',
                        desc: 'Learn about cultures throughout time by examining things they left behind.',
                      ),
                    ],
                  ),
                ),
                IgnorePointer(
                  child: SizedBox(
                    height: _imageHeight,
                    child: ValueListenableBuilder(
                      valueListenable: _currentPage,
                      builder: (_, value, __) {
                        late Widget child;
                        if (value == 0) {
                          child = _Page1Image();
                        } else if (value == 1) {
                          child = _Page2Image();
                        } else {
                          child = _Page3Image();
                        }
                        return AnimatedSwitcher(
                          duration: $styles.times.med,
                          child: child,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Gap($styles.insets.xl),

            /// Page Indicator
            AppPageIndicator(count: 3, controller: _pageController, color: $styles.colors.offWhite),
            Spacer(),

            /// Bottom text / button
            ValueListenableBuilder(
                valueListenable: _currentPage,
                builder: (_, page, __) {
                  return Stack(
                    children: [
                      Center(
                        child: AnimatedOpacity(
                          opacity: page == 2 ? 0 : 1,
                          duration: $styles.times.fast,
                          child: Semantics(
                            onTapHint: 'Navigate',
                            onTap: () {
                              var current = _pageController.page!.round();
                              _pageController.animateToPage(current + 1,
                                  duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
                            },
                            child: Text('Swipe left to continue', style: $styles.text.bodySmall.copyWith(height: 3)),
                          ),
                        ),
                      ),
                      CenterRight(
                        child: AnimatedOpacity(
                          opacity: page == 2 ? 1 : 0,
                          duration: $styles.times.fast,
                          child: CircleIconBtn(
                            icon: Icons.chevron_right,
                            bgColor: $styles.colors.accent1,
                            onPressed: _handleIntroCompletePressed,
                            semanticLabel: 'Enter the app',
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ).animate().fadeIn(delay: 500.ms),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({Key? key, required this.title, required this.desc}) : super(key: key);
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // Reads content as it changes without the user focus on it.
      liveRegion: true,
      child: Column(
        children: [
          SizedBox(height: _IntroScreenState._imageHeight, width: _IntroScreenState._imageHeight),
          Gap($styles.insets.lg),
          Text(title, style: $styles.text.wonderTitle.copyWith(fontSize: 24)),
          Gap($styles.insets.sm),
          Text(desc, style: $styles.text.body),
        ],
      ),
    );
  }
}

class _WonderousLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          SvgPaths.compassSimple,
          color: $styles.colors.offWhite,
          height: 48,
        ),
        Gap($styles.insets.xs),
        Text(
          'Wonderous',
          style: $styles.text.wonderTitle.copyWith(fontSize: 32, color: $styles.colors.offWhite),
        )
      ],
    );
  }
}

class _Page1Image extends StatelessWidget {
  const _Page1Image({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            '${ImagePaths.common}/intro-camel.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
          ),
        ),
        Positioned.fill(
            child: Image.asset(
          '${ImagePaths.common}/intro-mask-1.png',
          fit: BoxFit.fill,
        )),
      ],
    );
  }
}

class _Page2Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            '${ImagePaths.common}/intro-petra.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        Positioned.fill(
            child: Image.asset(
          '${ImagePaths.common}/intro-mask-2.png',
          fit: BoxFit.fill,
        )),
      ],
    );
  }
}

class _Page3Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            '${ImagePaths.common}/intro-statue.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        Positioned.fill(
            child: Image.asset(
          '${ImagePaths.common}/intro-mask-3.png',
          fit: BoxFit.fill,
        )),
      ],
    );
  }
}
