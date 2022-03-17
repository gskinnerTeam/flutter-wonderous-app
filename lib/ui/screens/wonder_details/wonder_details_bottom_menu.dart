import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/buttons.dart';

class WonderDetailsBottomMenu extends StatelessWidget {
  const WonderDetailsBottomMenu({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.surface1,
      child: Row(
        children: [
          _TabBtn(0, tabController, icon: Icons.info_outline),
          _TabBtn(1, tabController, icon: Icons.image_outlined),
          _TabBtn(2, tabController, icon: Icons.search),
          _TabBtn(3, tabController, icon: Icons.timelapse),
        ],
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
        child: Padding(
            padding: EdgeInsets.all(context.insets.lg),
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
