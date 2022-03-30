import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/animated_fractional_offset.dart';
import 'package:wonders/ui/common/buttons.dart';
import 'package:wonders/ui/common/circle_button.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';

class WonderDetailsBottomMenu extends StatelessWidget {
  const WonderDetailsBottomMenu({Key? key, required this.tabController, this.showBg = false}) : super(key: key);
  final TabController tabController;
  final bool showBg;

  @override
  Widget build(BuildContext context) {
    Color tabIconColor = showBg ? context.colors.textOnBg : context.colors.text;
    final double homeBtnSize = 70;
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
                    child: AnimatedFractionalOffset(
                      duration: context.times.fast,
                      curve: Curves.easeOut,
                      offset: Offset(0, showBg ? 0 : 1),
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
                child: _WonderHomeBtn(size: homeBtnSize),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class _WonderHomeBtn extends StatelessWidget {
  const _WonderHomeBtn({Key? key, required this.size}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      onPressed: () => Navigator.of(context).pop(),
      bgColor: context.colors.accent1,
      border: BorderSide(color: context.colors.bg, width: 6),
      child: SizedBox(
          width: size,
          height: size,
          child: Transform.scale(scale: 1.3, child: WonderIllustration(WonderType.chichenItza))),
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
