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
  late final AnimationController _anim = AnimationController(vsync: this, duration: 1500.ms);

  int getCloudSeed(WonderType type) {
    switch (type) {
      case WonderType.chichenItza:
        return 2;
      case WonderType.christRedeemer:
        return 3;
      case WonderType.colosseum:
        return 4;
      case WonderType.greatWall:
        return 5;
      case WonderType.machuPicchu:
        return 6;
      case WonderType.petra:
        return 7;
      case WonderType.pyramidsGiza:
        return 8;
      case WonderType.tajMahal:
        return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      setState(() => _clouds = _getClouds());
    });
    _showClouds();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _showClouds() {
    widget.enableAnimations ? _anim.forward(from: 0) : _anim.value = 1;
  }

  @override
  void didUpdateWidget(covariant AnimatedClouds oldWidget) {
    if (oldWidget.wonderType != widget.wonderType) {
      _oldClouds = _clouds;
      _clouds = _getClouds();
      _showClouds();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildCloud(c, {required bool isOld, required int startOffset}) {
      // Use a positive, or negative start offset, based on index
      final stOffset = _clouds.indexOf(c) % 2 == 0 ? -startOffset : startOffset;
      // If old, we will end at the stOffset and start at 0, if new, start at stOffset, and end at 0
      double curvedValue = Curves.easeOut.transform(_anim.value);
      return Positioned(
        top: c.pos.dy,
        left: isOld ? c.pos.dx - stOffset * curvedValue : c.pos.dx + stOffset * (1 - curvedValue),
        child: c,
      );
    }

    bool enableClouds = watchX((SettingsLogic s) => s.enableClouds);
    if (!enableClouds) return SizedBox.shrink();
    return ClipRect(
      child: OverflowBox(
        child: AnimatedBuilder(
          animation: _anim,
          builder: (_, __) => Stack(clipBehavior: Clip.hardEdge, key: ValueKey(widget.wonderType), children: [
            if (_anim.value != 1) ...[
              ..._oldClouds.map((c) => buildCloud(c, isOld: true, startOffset: 1000)),
            ],
            ..._clouds.map((c) => buildCloud(c, isOld: false, startOffset: 1000)),
          ]),
        ),
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
        child: SizedBox(
            width: 300,
            child: Image.asset(ImagePaths.cloud, opacity: const AlwaysStoppedAnimation(.4), cacheWidth: 300)),
      );
}
