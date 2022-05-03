import 'package:loading_indicator/loading_indicator.dart';
import 'package:wonders/common_libs.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key, this.color}) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 40,
        height: 40,
        child: LoadingIndicator(colors: [color ?? context.colors.accent1], indicatorType: Indicator.ballRotateChase),
      );
}
