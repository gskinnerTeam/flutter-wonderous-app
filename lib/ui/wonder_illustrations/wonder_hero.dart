import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_config.dart';

/// Utility class that wraps a normal [Hero] widget, but respects WonderIllustrationConfig.enableHero setting
class WonderHero extends StatelessWidget {
  const WonderHero(this.config, this.tag, {Key? key, required this.child}) : super(key: key);
  final WonderIllustrationConfig config;
  final Widget child;
  final String tag;
  @override

  /// TODO: Need to disable heroes when not visible... VisibilityDetector?
  Widget build(BuildContext context) {
    return config.enableHero ? Hero(tag: tag, child: child) : child;
  }
}
