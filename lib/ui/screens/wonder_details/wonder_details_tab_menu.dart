import 'package:wonders/common_libs.dart';

class WonderDetailsTabMenu extends StatelessWidget {
  static double bottomPadding = 0;
  static double buttonInset = 12;

  const WonderDetailsTabMenu(
      {Key? key,
      required this.tabController,
      this.showBg = false,
      required this.wonderType,
      this.axis = Axis.horizontal})
      : super(key: key);

  final TabController tabController;
  final bool showBg;
  final WonderType wonderType;
  final Axis axis;
  bool get isVertical => axis == Axis.vertical;

  @override
  Widget build(BuildContext context) {
    Color iconColor = showBg ? $styles.colors.black : $styles.colors.white;
    const double homeBtnSize = 74;
    // Use SafeArea padding if its more than the default padding.
    bottomPadding = max(context.mq.padding.bottom, $styles.insets.xs * 1.5);
    return Stack(
      children: [
        /// Background, animates in and out based on `showBg`
        Positioned.fill(
          child: AnimatedOpacity(
            duration: $styles.times.fast,
            opacity: showBg ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(
                top: isVertical ? context.mq.viewPadding.top : buttonInset,
                right: isVertical ? buttonInset : 0,
              ),
              child: ColoredBox(color: $styles.colors.offWhite),
            ),
          ),
        ),

        /// Buttons
        /// A Stack with a row or column of tabButtons, and an illustrated homeButton sitting on top.
        Padding(
          padding: EdgeInsets.only(left: $styles.insets.sm, right: $styles.insets.xxs, bottom: bottomPadding),
          child: Stack(
            children: [
              SizedBox(
                width: isVertical ? null : double.infinity,
                height: isVertical ? double.infinity : null,
                child: FocusTraversalGroup(
                  child: Flex(
                    direction: axis,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: isVertical ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Home btn
                      _WonderHomeBtn(
                        size: homeBtnSize,
                        wonderType: wonderType,
                        borderSize: showBg ? 6 : 2,
                      ),

                      /// Tabs
                      _TabBtn(
                        0,
                        tabController,
                        iconImg: 'editorial',
                        label: $strings.wonderDetailsTabLabelInformation,
                        color: iconColor,
                        axis: axis,
                      ),
                      _TabBtn(
                        1,
                        tabController,
                        iconImg: 'photos',
                        label: $strings.wonderDetailsTabLabelImages,
                        color: iconColor,
                        axis: axis,
                      ),
                      _TabBtn(
                        2,
                        tabController,
                        iconImg: 'artifacts',
                        label: $strings.wonderDetailsTabLabelArtifacts,
                        color: iconColor,
                        axis: axis,
                      ),
                      _TabBtn(3, tabController,
                          iconImg: 'timeline',
                          label: $strings.wonderDetailsTabLabelEvents,
                          color: iconColor,
                          axis: axis),
                    ],
                  ),
                ),
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
    required this.axis,
  }) : super(key: key);

  static const double minSize = 50;
  static const double maxSize = 100;
  static const double crossBtnSize = 60;

  final int index;
  final TabController tabController;
  final String iconImg;
  final Color color;
  final String label;
  final Axis axis;

  bool get _isVertical => axis == Axis.vertical;

  @override
  Widget build(BuildContext context) {
    bool selected = tabController.index == index;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final iconImgPath = '${ImagePaths.common}/tab-$iconImg${selected ? '-active' : ''}.png';
    String tabLabel = localizations.tabLabel(tabIndex: index + 1, tabCount: tabController.length);
    tabLabel = '$label: $tabLabel';
    final double mainBtnSize = ((_isVertical ? context.heightPx : context.widthPx) / 6).clamp(minSize, maxSize);
    return MergeSemantics(
      child: Semantics(
        selected: selected,
        label: tabLabel,
        child: ExcludeSemantics(
          child: AppBtn.basic(
            padding: EdgeInsets.only(top: $styles.insets.md + $styles.insets.xs, bottom: $styles.insets.sm),
            onPressed: () => tabController.index = index,
            semanticLabel: label,
            minimumSize: _isVertical ? Size(crossBtnSize, mainBtnSize) : Size(mainBtnSize, crossBtnSize),
            // Image icon
            child: Image.asset(iconImgPath, height: 32, width: 32, color: selected ? null : color),
          ),
        ),
      ),
    );
  }
}
