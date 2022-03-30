import 'package:wonders/common_libs.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({Key? key, required this.child, this.bgColor}) : super(key: key);
  final Widget child;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colors.bg,
        body: SafeArea(child: child),
      );
}
