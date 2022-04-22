import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ColosseumIllustration extends StatelessWidget {
  const ColosseumIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) {
    //String assetPath = WonderType.colosseum.assetPath;
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: (_, __) => [FlutterLogo()],
      mgBuilder: (_, __) => [FlutterLogo()],
      fgBuilder: (_, __) => [FlutterLogo()],
    );
  }
}
