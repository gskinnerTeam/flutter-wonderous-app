import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class MachuPicchuIllustration extends StatelessWidget {
  const MachuPicchuIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) {
    //String assetPath = WonderType.machuPicchu.assetPath;
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: (_, __) => [FlutterLogo()],
      mgBuilder: (_, __) => [FlutterLogo()],
      fgBuilder: (_, __) => [FlutterLogo()],
    );
  }
}
