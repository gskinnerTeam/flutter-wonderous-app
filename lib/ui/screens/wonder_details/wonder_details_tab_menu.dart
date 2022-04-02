import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/buttons.dart';
import 'package:wonders/ui/common/controls/circle_button.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_config.dart';

class WonderDetailsTabMenu extends StatelessWidget {
  const WonderDetailsTabMenu({Key? key, required this.tabController, this.showBg = false, required this.wonderType})
      : super(key: key);
  final TabController tabController;
  final bool showBg;
  final WonderType wonderType;

  @override
  Widget build(BuildContext context) {
    Color tabIconColor = showBg ? context.colors.textOnBg : context.colors.text;
    const double homeBtnSize = 70;
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(top: context.insets.xs),
        child: Stack(
          children: [
            BottomCenter(
              child: Stack(
                children: [
                  // Background
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: context.times.fast,
                      opacity: showBg ? 1 : 0,
                      child: ColoredBox(color: context.colors.bg),
                    ),
                  ),
                  // Buttons
                  Padding(
                    padding: EdgeInsets.only(bottom: context.insets.xs),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: context.times.fast,
                          curve: Curves.easeOut,
                          width: homeBtnSize + context.insets.xs * 2,
                          height: 1,
                        ),
                        _TabBtn(0, tabController, icon: Icons.info_outline, iconColor: tabIconColor),
                        _TabBtn(1, tabController, icon: Icons.image_outlined, iconColor: tabIconColor),
                        _TabBtn(2, tabController, icon: Icons.search, iconColor: tabIconColor),
                        _TabBtn(3, tabController, icon: Icons.timelapse, iconColor: tabIconColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomLeft(
              child: Padding(
                padding: EdgeInsets.all(context.insets.xs),
                child: _WonderHomeBtn(
                  size: homeBtnSize,
                  wonderType: wonderType,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
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
