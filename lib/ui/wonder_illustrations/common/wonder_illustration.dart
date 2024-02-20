import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/chichen_itza_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/christ_redeemer_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/colosseum_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/great_wall_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/machu_picchu_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/petra_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/pyramids_giza_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/taj_mahal_illustration.dart';

/// Convenience class for showing an illustration when all you have is the type.
class WonderIllustration extends StatelessWidget {
  const WonderIllustration(this.type, {super.key, required this.config});
  final WonderIllustrationConfig config;
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      WonderType.chichenItza => ChichenItzaIllustration(config: config),
      WonderType.christRedeemer => ChristRedeemerIllustration(config: config),
      WonderType.colosseum => ColosseumIllustration(config: config),
      WonderType.greatWall => GreatWallIllustration(config: config),
      WonderType.machuPicchu => MachuPicchuIllustration(config: config),
      WonderType.petra => PetraIllustration(config: config),
      WonderType.pyramidsGiza => PyramidsGizaIllustration(config: config),
      WonderType.tajMahal => TajMahalIllustration(config: config)
    };
  }
}
