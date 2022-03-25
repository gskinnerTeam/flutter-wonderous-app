import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_loader.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = context.style;

    // TEST 1 - Runtime error
    /*
    int? thing;
    print(thing! + thing);
    */

    // TEST 2 - Layout error
    /*
    return Column(children: [
      ListView(children: [Placeholder(fallbackHeight: 1000)])
    ]);

    */

    return Scaffold(
      backgroundColor: style.colors.bg,
      body: Center(
        child: AppLoader(),
      ),
    );
  }
}
