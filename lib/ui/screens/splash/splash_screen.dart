import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bg,
      body: Center(
        child: AppLoader(),
      ),
    );
  }
}
