import 'package:wonders/common_libs.dart';

class CenteredBox extends StatelessWidget {
  const CenteredBox({super.key, required this.child, this.width, this.height, this.padding});
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) => Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Center(
          child: SizedBox(
            width: width,
            height: height,
            child: child,
          ),
        ),
      );
}
