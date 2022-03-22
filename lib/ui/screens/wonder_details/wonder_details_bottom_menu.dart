import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/buttons.dart';
import 'package:wonders/ui/common/circle_button.dart';

class WonderDetailsBottomMenu extends StatelessWidget {
  const WonderDetailsBottomMenu({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    double largeBtnHeight = 60;
    double tabBtnHeight = largeBtnHeight * .85;

    return Stack(
      children: [
        BottomCenter(
          child: SizedBox(
            height: largeBtnHeight,
            child: Padding(
              padding: EdgeInsets.only(top: largeBtnHeight - tabBtnHeight),
              child: Container(
                color: context.colors.surface1,
                child: Row(
                  children: [
                    /// Use an invisible wonder btn as placeholder
                    Opacity(opacity: 0, child: _WonderHomeBtn(largeBtnHeight)),
                    _TabBtn(0, tabController, icon: Icons.info_outline),
                    _TabBtn(1, tabController, icon: Icons.image_outlined),
                    _TabBtn(2, tabController, icon: Icons.search),
                    _TabBtn(3, tabController, icon: Icons.timelapse),
                  ],
                ),
              ),
            ),
          ),
        ),
        _WonderHomeBtn(largeBtnHeight),
      ],
    );
  }
}

class _WonderHomeBtn extends StatelessWidget {
  const _WonderHomeBtn(this.size, {Key? key}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      onPressed: () => Navigator.of(context).pop(),
      bgColor: Colors.grey.shade800,
      child: Container(
        width: size,
        height: size,
        child: Icon(Icons.arrow_upward),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  const _TabBtn(this.index, this.tabController, {Key? key, required this.icon}) : super(key: key);
  final int index;
  final TabController tabController;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppBtn(
        child: SizedBox(
            height: double.infinity,
            child: Icon(
              icon,
              color: index == tabController.index ? context.colors.fg : context.colors.accent,
              size: 32,
            )),
        onPressed: () => tabController.index = index,
      ),
    );
  }
}
