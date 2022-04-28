import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class MachuPicchuIllustration extends StatelessWidget {
  MachuPicchuIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.machuPicchu.assetPath;
  final fgColor = WonderType.machuPicchu.fgColor;
  final bgColor = WonderType.machuPicchu.bgColor;

  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: _buildBg,
      mgBuilder: _buildMg,
      fgBuilder: _buildFg,
    );
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> animation) => [];
  List<Widget> _buildMg(BuildContext context, Animation<double> animation) => [];
  List<Widget> _buildBg(BuildContext context, Animation<double> animation) => [];
}
