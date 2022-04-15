import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/chichen_itza_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/taj_mahal_illustration.dart';

/// Convenience class for showing an illustration when all you have is the type.
class WonderIllustration extends StatelessWidget {
  const WonderIllustration(this.type, {Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case WonderType.chichenItza:
        return ChichenItzaIllustration(config: config);
      case WonderType.tajMahal:
        return TajMahalIllustration(config: config);
      default:
        return Text('Sorry, wonder illustration not found.');
    }
  }
}
