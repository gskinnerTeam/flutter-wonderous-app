import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';

class AppPageIndicator extends StatefulWidget {
  AppPageIndicator(
      {Key? key,
      required this.count,
      required this.controller,
      this.onDotPressed,
      this.color,
      this.dotSize,
      String? semanticPageTitle})
      : semanticPageTitle = semanticPageTitle ?? $strings.appPageDefaultTitlePage,
        super(key: key);
  final int count;
  final PageController controller;
  final void Function(int index)? onDotPressed;
  final Color? color;
  final double? dotSize;
  final String semanticPageTitle;

  @override
  State<AppPageIndicator> createState() => _AppPageIndicatorState();
}

class _AppPageIndicatorState extends State<AppPageIndicator> {
  final _currentPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handlePageChanged);
  }

  void _handlePageChanged() {
    _currentPage.value = widget.controller.page?.round() ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPage,
      builder: (_, value, child) => Semantics(
        label: StringUtils.supplant($strings.appPageSemanticSwipe, {
          '{pageTitle}': widget.semanticPageTitle,
          '{count}': (value % (widget.count) + 1).toString(),
          '{total}': widget.count.toString(),
        }),
        child: child,
      ),
      child: IgnorePointer(
        ignoringSemantics: false,
        child: Container(
          color: Colors.transparent,
          height: 30,
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: widget.controller,
            count: widget.count,
            onDotClicked: widget.onDotPressed,
            effect: ExpandingDotsEffect(
                dotWidth: widget.dotSize ?? 6,
                dotHeight: widget.dotSize ?? 6,
                paintStyle: PaintingStyle.fill,
                strokeWidth: (widget.dotSize ?? 6) / 2,
                dotColor: widget.color ?? $styles.colors.accent1,
                activeDotColor: widget.color ?? $styles.colors.accent1,
                expansionFactor: 2),
          ),
        ),
      ),
    );
  }
}
