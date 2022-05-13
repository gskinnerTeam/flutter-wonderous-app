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
    Color iconColor = showBg ? context.colors.black : context.colors.white;
    const double homeBtnSize = 70;
    // Use SafeArea padding if its more than the default padding.
    bottomPadding = max(context.mq.padding.bottom, context.insets.xs);
    return Stack(
      children: [
        //Background
        Positioned.fill(
          child: AnimatedOpacity(
            duration: context.times.fast,
            opacity: showBg ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(top: buttonInset),
              child: ColoredBox(color: context.colors.offWhite),
            ),
          ),
        ),
        // Buttons
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.insets.xs).copyWith(bottom: bottomPadding),
          // TabButtons are a Stack with a row of icon buttons, and an illustrated home button sitting on top.
          // The home buttons shows / hides itself based on `showHomeBtn`
          // The row contains an animated placeholder gap which makes room for the icon as it transitions in.
          child: Stack(
            children: [
              // Main tab btns + animated gap
              Padding(
                padding: EdgeInsets.only(top: buttonInset),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Holds a gap for the Home button which pushed the other icons to the side
                    AnimatedContainer(
                        curve: Curves.easeOut,
                        duration: context.times.fast,
                        width: showHomeBtn ? homeBtnSize : 0,
                        height: 0),
                    _TabBtn(0, tabController, iconImg: 'editorial', label: 'information', color: iconColor),
                    _TabBtn(1, tabController, iconImg: 'photos', label: 'images', color: iconColor),
                    _TabBtn(2, tabController, iconImg: 'artifacts', label: 'artifact search', color: iconColor),
                    _TabBtn(3, tabController, iconImg: 'timeline', label: 'timeline', color: iconColor),
                  ],
                ),
              ),

              // Home btn, animates into view
              TweenAnimationBuilder<double>(
                duration: context.times.fast,
                tween: Tween(begin: 0, end: showHomeBtn ? 1 : 0),
                child: _WonderHomeBtn(size: homeBtnSize, wonderType: wonderType),
                builder: (_, value, child) {
                  final curvedValue = Curves.easeOut.transform(value);
                  return Transform.scale(
                    scale: .5 + .5 * curvedValue,
                    child: Transform.translate(
                      offset: Offset(0, 100 * (1 - curvedValue)),
                      child: AnimatedOpacity(
                        opacity: showHomeBtn ? 1 : 0,
                        child: child!,
                        duration: context.times.fast,
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
  const _WonderHomeBtn({Key? key, required this.size, required this.wonderType}) : super(key: key);
  final double size;
  final WonderType wonderType;
  @override
  Widget build(BuildContext context) {
    return CircleBtn(
      onPressed: () => Navigator.of(context).pop(),
      bgColor: wonderType.fgColor,
      border: BorderSide(color: context.colors.offWhite, width: 6),
      semanticLabel: 'back to wonder selection',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: SizedBox(width: size, height: size, child: Image.asset(wonderType.homeBtn)),
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

    Widget buildDot([double size = 4]) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color: context.colors.accent1,
          ),
        );

    return Expanded(
      child: AppBtn.basic(
        padding: EdgeInsets.symmetric(vertical: context.insets.md),
        child: Stack(
          children: [
            /// Image icon
            Image.asset(
              '${ImagePaths.common}/tab-$iconImg${selected ? '-active' : ''}.png',
              height: 32,
              width: 32,
              color: selected ? null : color,
            ),

            /// Dot, shows when selected
            Positioned.fill(
              child: BottomCenter(
                child: buildDot().fx(key: ValueKey(selected)).fade(begin: selected ? 0 : 1, end: selected ? 1 : 0).move(
                    curve: selected ? Curves.easeOutBack : Curves.easeIn,
                    duration: context.times.med,
                    begin: Offset(0, selected ? 30 : 5),
                    end: Offset(0, selected ? 5 : 30)),
              ),
            )
          ],
        ),
        onPressed: () => tabController.index = index,
        semanticLabel: label,
      ),
    );
  }
}
