import 'package:wonders/common_libs.dart';

class AppBtn extends StatelessWidget {
  const AppBtn({Key? key, required this.child, required this.onPressed}) : super(key: key);
  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        //backgroundColor: context.style.colors.bg,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: child,
      onPressed: onPressed,
    );
  }

  static Widget tight(BuildContext context, {required Widget child, required VoidCallback? onPressed}) => TextButton(
      style: TextButton.styleFrom(
        //backgroundColor: context.style.colors.bg,
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: child);

  static Widget wide(BuildContext context, {required Widget child, required VoidCallback? onPressed}) => OutlinedButton(
      style: TextButton.styleFrom(
        //backgroundColor: context.style.colors.bg,
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
      ),
      onPressed: onPressed,
      child: child);
}
