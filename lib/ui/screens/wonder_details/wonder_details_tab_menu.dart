import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/buttons.dart';
import 'package:wonders/ui/common/controls/circle_button.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration.dart';

class WonderDetailsTabMenu extends StatelessWidget {
  const WonderDetailsTabMenu(
      {Key? key, required this.tabController, this.showBg = false, required this.wonderType, required this.showHomeBtn})
      : super(key: key);
  final TabController tabController;
  final bool showBg;
  final WonderType wonderType;
  final bool showHomeBtn;

  @override
  Widget build(BuildContext context) {
    Color tabIconColor = showBg ? context.colors.textOnBg : context.colors.text;
    const double homeBtnSize = 70;
    const double buttonInset = 12;
    // Use SafeArea padding if its more than the default padding.
    double bottomInset = max(context.mq.padding.bottom, context.insets.xs);
    return Stack(
      children: [
        //Background
        Positioned.fill(
          child: AnimatedOpacity(
            duration: context.times.fast,
            opacity: showBg ? 1 : 0,
            child: Padding(
              padding: EdgeInsets.only(top: buttonInset),
              child: ColoredBox(color: context.colors.bg),
            ),
          ),
        ),
        // Buttons
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.insets.xs).copyWith(bottom: bottomInset),
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
                    AnimatedContainer(
                        curve: Curves.easeOut,
                        duration: context.times.fast,
                        width: showHomeBtn ? homeBtnSize : 0,
                        height: 0),
                    _TabBtn(0, tabController, icon: Icons.info_outline, iconColor: tabIconColor),
                    _TabBtn(1, tabController, icon: Icons.image_outlined, iconColor: tabIconColor),
                    _TabBtn(2, tabController, icon: Icons.search, iconColor: tabIconColor),
                    _TabBtn(3, tabController, icon: Icons.timelapse, iconColor: tabIconColor),
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
    return CircleButton(
      onPressed: () => Navigator.of(context).pop(),
      bgColor: context.colors.accent1,
      border: BorderSide(color: context.colors.bg, width: 6),
      child: SizedBox(
          width: size,
          height: size,
          child: Transform.scale(
            scale: 1.3,
            child: WonderIllustration(
              wonderType,
              config: WonderIllustrationConfig.mg(enableHero: false),
            ),
          )),
    );
  }
}

class _TabBtn extends StatelessWidget {
  const _TabBtn(this.index, this.tabController, {Key? key, required this.icon, required this.iconColor})
      : super(key: key);
  final int index;
  final TabController tabController;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppBtn(
        child: Icon(
          icon,
          color: index == tabController.index ? context.colors.accent1 : iconColor,
          size: 32,
        ),
        onPressed: () => tabController.index = index,
      ),
    );
  }
}
