import 'dart:async';

import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/utils/context_utils.dart';

// Shows a set of clouds that animated onto stage.
// When value-key is changed, a new set of clouds will animate into place and the old ones will animate out.
class AnimatedClouds extends StatefulWidget with GetItStatefulWidgetMixin {
  AnimatedClouds({Key? key, this.enableAnimations = true, required this.wonderType}) : super(key: key);
  final WonderType wonderType;
  final bool enableAnimations;
  @override
  State<AnimatedClouds> createState() => _AnimatedCloudsState();
}

class _AnimatedCloudsState extends State<AnimatedClouds> with SingleTickerProviderStateMixin, GetItStateMixin {
  late List<_Cloud> _clouds = [];
  List<_Cloud> _oldClouds = [];

  int getCloudSeed(WonderType type) {
    switch (type) {
      case WonderType.chichenItza:
        return 2;
      case WonderType.tajMahal:
        return 1;
      default:
        return -1;
    }
  }

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      setState(() => _clouds = _getClouds());
    });
  }

  @override
  void didUpdateWidget(covariant AnimatedClouds oldWidget) {
    if (oldWidget.wonderType != widget.wonderType) {
      _oldClouds = _clouds;
      _clouds = _getClouds();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildCloud(c, {required bool isOld, required int startOffset}) => FXRunAnimated(
          (_, value) {
            // Use a positive, or negative start offset, based on index
            final stOffset = _clouds.indexOf(c) % 2 == 0 ? -startOffset : startOffset;
            // If old, we will end at the stOffset and start at 0, if new, start at stOffset, and end at 0
            final offset = (isOld ? (value ? 0 : stOffset) : (value ? stOffset : 0));
            return AnimatedPositioned(
              curve: isOld ? Curves.easeIn : Curves.easeOut,
              duration: widget.enableAnimations ? context.times.slow : Duration.zero,
              top: c.pos.dy,
              left: c.pos.dx + offset,
              child: c,
            );
          },
        );
    bool enableClouds = watchX((SettingsLogic s) => s.enableClouds);
    if (!enableClouds) return SizedBox.shrink();
    return ClipRect(
      child: OverflowBox(
        child: Stack(clipBehavior: Clip.hardEdge, key: ValueKey(widget.wonderType), children: [
          ..._oldClouds.map((c) => buildCloud(c, isOld: true, startOffset: 1000)),
          ..._clouds.map((c) => buildCloud(c, isOld: false, startOffset: 1000)),
        ]),
      ),
    );
  }

  List<_Cloud> _getClouds() {
    Size size = ContextUtils.getSize(context) ?? Size(context.widthPx, 400);
    rndSeed = getCloudSeed(widget.wonderType);
    return List<_Cloud>.generate(4, (index) {
      return _Cloud(
        Offset(rnd.getDouble(-200, size.width - 100), rnd.getDouble(50, size.height - 50)),
        scale: rnd.getDouble(.5, 1),
        flipX: rnd.getBool(),
        flipY: rnd.getBool(),
      );
    }).toList();
  }
}

class _Cloud extends StatelessWidget {
  final Offset pos;
  final double scale;
  final bool flipX;
  final bool flipY;

  const _Cloud(this.pos, {this.scale = 1, this.flipX = false, this.flipY = false});

  @override
  Widget build(BuildContext context) => Transform.scale(
        scaleX: scale * (flipX ? -1 : 1),
        scaleY: scale * (flipY ? -1 : 1),
        child: Image.asset(ImagePaths.cloud, opacity: const AlwaysStoppedAnimation(.4), cacheWidth: 300),
      );
}
