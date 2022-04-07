import 'package:wonders/common_libs.dart';

class GreyScale extends StatelessWidget {
  final Widget child;

  const GreyScale({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.saturation),
      child: child,
    );
  }
}
