import 'package:wonders/common_libs.dart';

class WonderDetailsTabMenu extends StatelessWidget {
  static double bottomPadding = 0;
  static double buttonInset = 12;

  const WonderDetailsTabMenu(
      {Key? key, required this.tabController, this.showBg = false, required this.wonderType, required this.showHomeBtn})
      : super(key: key);

  final TabController tabController;
  final bool showBg;
  final WonderType wonderType;
  final bool showHomeBtn;

  @override
  Widget build(BuildContext context) {
    Color iconColor = showBg ? $styles.colors.black : $styles.colors.white;
    const double homeBtnSize = 74;
    // Use SafeArea padding if its more than the default padding.
    bottomPadding = max(context.mq.padding.bottom, $styles.insets.xs * 1.5);
    return Stack(
      children: [
        //Background
        Positioned.fill(
          child: AnimatedOpacity(
            duration: $styles.times.fast,
            opacity: showBg ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(top: buttonInset),
              child: ColoredBox(color: $styles.colors.offWhite),
            ),
          ),
        ),
        // Buttons
        Padding(
          padding: EdgeInsets.only(left: $styles.insets.sm, right: $styles.insets.xxs, bottom: bottomPadding),
          // TabButtons are a Stack with a row of icon buttons, and an illustrated home button sitting on top.
          // The home buttons shows / hides itself based on `showHomeBtn`
          // The row contains an animated placeholder gap which makes room for the icon as it transitions in.
          child: Stack(
            children: [
              // Main tab btns + animated gap
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Holds a gap for the Home button which pushed the other icons to the side
                  AnimatedContainer(
                    curve: Curves.easeOut,
                    duration: $styles.times.fast,
                    width: showHomeBtn ? homeBtnSize : 0,
                    height: 0,
                  ),
                  _TabBtn(0, tabController,
                      iconImg: 'editorial', label: $strings.wonderDetailsTabLabelInformation, color: iconColor),
                  _TabBtn(1, tabController,
                      iconImg: 'photos', label: $strings.wonderDetailsTabLabelImages, color: iconColor),
                  _TabBtn(2, tabController,
                      iconImg: 'artifacts', label: $strings.wonderDetailsTabLabelArtifacts, color: iconColor),
                  _TabBtn(3, tabController,
                      iconImg: 'timeline', label: $strings.wonderDetailsTabLabelEvents, color: iconColor),
                ],
              ),

              // Home btn
              TweenAnimationBuilder<double>(
                duration: $styles.times.fast,
                tween: Tween(begin: 0, end: showHomeBtn ? 1 : 0),
                child: _WonderHomeBtn(
                  size: homeBtnSize,
                  wonderType: wonderType,
                  borderSize: showBg ? 6 : 2,
                ),
                builder: (_, value, child) {
                  final curvedValue = Curves.easeOut.transform(value);
                  return Transform.scale(
                    scale: .5 + .5 * curvedValue,
                    child: Transform.translate(
                      offset: Offset(0, 100 * (1 - curvedValue)),
                      child: AnimatedOpacity(
                        opacity: showHomeBtn ? 1 : 0,
                        duration: $styles.times.fast,
                        child: child!,
                      ),
                    ),
                  );
                },
                // Wonder Button
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WonderHomeBtn extends StatelessWidget {
  const _WonderHomeBtn({Key? key, required this.size, required this.wonderType, required this.borderSize})
      : super(key: key);

  final double size;
  final WonderType wonderType;
  final double borderSize;

  @override
  Widget build(BuildContext context) {
    return CircleBtn(
      onPressed: () => Navigator.of(context).pop(),
      bgColor: $styles.colors.offWhite,
      semanticLabel: $strings.wonderDetailsTabSemanticBack,
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: $styles.times.fast,
        width: size - borderSize * 2,
        height: size - borderSize * 2,
        margin: EdgeInsets.all(borderSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          color: wonderType.fgColor,
          image: DecorationImage(image: AssetImage(wonderType.homeBtn), fit: BoxFit.fill),
        ),
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  const _TabBtn(
    this.index,
    this.tabController, {
    Key? key,
    required this.iconImg,
    required this.color,
    required this.label,
  }) : super(key: key);

  final int index;
  final TabController tabController;
  final String iconImg;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    bool selected = tabController.index == index;

    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final iconImgPath = '${ImagePaths.common}/tab-$iconImg${selected ? '-active' : ''}.png';
    String tabLabel = localizations.tabLabel(tabIndex: index + 1, tabCount: tabController.length);
    tabLabel = '$label: $tabLabel';
    return Expanded(
      child: MergeSemantics(
        child: Semantics(
          selected: selected,
          label: tabLabel,
          child: ExcludeSemantics(
            child: AppBtn.basic(
              padding: EdgeInsets.only(top: $styles.insets.md + $styles.insets.xs, bottom: $styles.insets.sm),
              onPressed: () => tabController.index = index,
              semanticLabel: label,
              child: Stack(
                children: [
                  /// Image icon
                  Image.asset(iconImgPath, height: 32, width: 32, color: selected ? null : color),
                  if (selected)
                    Positioned.fill(
                      child: BottomCenter(
                        child: Transform.translate(
                          offset: Offset(0, $styles.insets.xxs),
                          child: Animate().custom(
                            curve: Curves.easeOutCubic,
                            end: 24,
                            builder: (_, v, __) => Container(height: 3, width: v, color: $styles.colors.accent1),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
