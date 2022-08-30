import 'package:wonders/common_libs.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({Key? key, this.value, this.color}) : super(key: key);
  final Color? color;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          color: color ?? $styles.colors.accent1,
          value: value,
          strokeWidth: 1.0,
        ),
      );
  }
}
