import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class IllustrationMg extends StatelessWidget {
  const IllustrationMg(
    this.imagePath, {
    Key? key,
    required this.config,
    required this.anim,
    required this.type,
    required this.heightFraction,
    this.maxHeight = 700,
  }) : super(key: key);

  final String imagePath;
  final WonderIllustrationConfig config;
  final Animation<double> anim;
  final WonderType type;
  final double maxHeight;
  final double heightFraction;
  String get assetPath => type.assetPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: $styles.insets.sm),
      child: LayoutBuilder(builder: (_, constraints) {
        final height = min(maxHeight, constraints.maxHeight) * heightFraction;
        return Center(
          child: WonderHero(
            config,
            '$imagePath-hero',
            child: Transform.scale(
              scale: 4 + config.zoom * .5,
              child: Image.asset(
                '$assetPath/$imagePath',
                opacity: anim,
                height: height * .25,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
    );
  }
}
