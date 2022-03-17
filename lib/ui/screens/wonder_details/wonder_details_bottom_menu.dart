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
          _TabBtn(icon: Icons.info_outline, onPressed: () => tabController.index = 0),
          _TabBtn(icon: Icons.image_outlined, onPressed: () => tabController.index = 1),
          _TabBtn(icon: Icons.search, onPressed: () => tabController.index = 2),
          _TabBtn(icon: Icons.timelapse, onPressed: () => tabController.index = 3),
        ],
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  const _TabBtn({Key? key, required this.onPressed, required this.icon}) : super(key: key);
  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppBtn(
        child: Padding(
            padding: EdgeInsets.all(context.insets.lg),
            child: Icon(
              icon,
              color: context.colors.accent,
              size: 32,
            )),
        onPressed: onPressed,
      ),
    );
  }
}
