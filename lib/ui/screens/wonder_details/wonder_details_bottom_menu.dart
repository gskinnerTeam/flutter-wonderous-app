import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/buttons.dart';

class WonderDetailsBottomMenu extends StatelessWidget {
  const WonderDetailsBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.surface1,
      child: Row(
        children: [
          _TabBtn(icon: Icons.timeline_outlined, onPressed: () {}),
          _TabBtn(icon: Icons.map, onPressed: () {}),
          _TabBtn(icon: Icons.search, onPressed: () {}),
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
        child: Padding(padding: EdgeInsets.all(context.insets.xl), child: Icon(icon, color: context.colors.accent)),
        onPressed: onPressed,
      ),
    );
  }
}
