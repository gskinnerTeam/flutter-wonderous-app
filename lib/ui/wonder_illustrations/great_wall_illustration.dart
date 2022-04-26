import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class GreatWallIllustration extends StatelessWidget {
  const GreatWallIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) {
    String assetPath = WonderType.greatWall.assetPath;
    final fgColor = WonderType.greatWall.fgColor;
    final bgColor = WonderType.greatWall.bgColor;
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: (_, __) => [FlutterLogo()],
      mgBuilder: (_, __) => [FlutterLogo()],
      fgBuilder: (_, __) => [FlutterLogo()],
    );
  }
}
