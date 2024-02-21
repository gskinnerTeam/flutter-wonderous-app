import 'dart:async';

import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/utils/context_utils.dart';

// TODO: Clouds should fade in and out
// Shows a set of clouds that animated onto stage.
// When value-key is changed, a new set of clouds will animate into place and the old ones will animate out.
// Uses a random seed system, to make sure we get the same set of clouds for each wonder, without actually having to hand-position them.
class AnimatedClouds extends StatefulWidget with GetItStatefulWidgetMixin {
  AnimatedClouds(
      {super.key, this.enableAnimations = true, required this.wonderType, required this.opacity, this.cloudSize = 500});
  final WonderType wonderType;
  final bool enableAnimations;
  final double opacity;
  final double cloudSize;
  @override
  State<AnimatedClouds> createState() => _AnimatedCloudsState();
}

class _AnimatedCloudsState extends State<AnimatedClouds> with SingleTickerProviderStateMixin, GetItStateMixin {
  late List<_Cloud> _clouds = [];
  List<_Cloud> _oldClouds = [];
  late final AnimationController _anim = AnimationController(vsync: this, duration: 1500.ms);

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

  @override
  void didUpdateWidget(covariant AnimatedClouds oldWidget) {
    if (oldWidget.wonderType != widget.wonderType) {
      _oldClouds = _clouds;
      _clouds = _getClouds();
      _showClouds();
    }
    super.didUpdateWidget(oldWidget);
  }

  int _getCloudSeed(WonderType type) {
    return switch (type) {
      WonderType.chichenItza => 2,
      WonderType.christRedeemer => 78,
      WonderType.colosseum => 1,
      WonderType.greatWall => 500,
      WonderType.machuPicchu => 37,
      WonderType.petra => 111,
      WonderType.pyramidsGiza => 15,
      WonderType.tajMahal => 2
    };
  }

  /// Starts playing the clouds animation, or jumps right to the end, based on [AnimatedClouds.enableAnimations]
  void _showClouds() {
    widget.enableAnimations ? _anim.forward(from: 0) : _anim.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    // Old clouds animate from 0 to startOffset, new clouds do the opposite.
    Widget buildCloud(_Cloud c, {required bool isOld, required int startOffset}) {
      // Use a positive, or negative start offset, based on index
      final stOffset = _clouds.indexOf(c) % 2 == 0 ? -startOffset : startOffset;
      // If old, we will end at the stOffset and start at 0, if new, start at stOffset, and end at 0
      double curvedValue = Curves.easeOut.transform(_anim.value);
      return Positioned(
        top: c.pos.dy,
        left: isOld ? c.pos.dx - stOffset * curvedValue : c.pos.dx + stOffset * (1 - curvedValue),
        child: Opacity(opacity: isOld ? 1 - _anim.value : _anim.value, child: c),
      );
    }

    return RepaintBoundary(
      child: ClipRect(
        child: OverflowBox(
          child: AnimatedBuilder(
            animation: _anim,
            builder: (_, __) {
              // A stack with 2 sets of clouds, one set is moving out of view while the other moves in.
              return Stack(
                clipBehavior: Clip.hardEdge,
                key: ValueKey(widget.wonderType),
                children: [
                  if (_anim.value != 1) ...[
                    ..._oldClouds.map((c) => buildCloud(c, isOld: true, startOffset: 1000)),
                  ],
                  ..._clouds.map((c) => buildCloud(c, isOld: false, startOffset: 1000)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<_Cloud> _getClouds() {
    Size size = ContextUtils.getSize(context) ?? Size(context.widthPx, 400);
    rndSeed = _getCloudSeed(widget.wonderType);
    return List<_Cloud>.generate(3, (index) {
      return _Cloud(
        Offset(rnd.getDouble(-200, size.width - 100), rnd.getDouble(50, size.height - 50)),
        scale: rnd.getDouble(.7, 1),
        flipX: rnd.getBool(),
        flipY: rnd.getBool(),
        opacity: widget.opacity,
        size: widget.cloudSize,
      );
    }).toList();
  }
}

class _Cloud extends StatelessWidget {
  const _Cloud(this.pos,
      {this.scale = 1, this.flipX = false, this.flipY = false, required this.opacity, required this.size});

  final Offset pos;
  final double scale;
  final bool flipX;
  final bool flipY;
  final double opacity;
  final double size;

  @override
  Widget build(BuildContext context) => Transform.scale(
        scaleX: scale * (flipX ? -1 : 1),
        scaleY: scale * (flipY ? -1 : 1),
        child: Image.asset(
          ImagePaths.cloud,
          opacity: AlwaysStoppedAnimation(.4 * opacity),
          width: size * scale,
          fit: BoxFit.fitWidth,
        ),
      );
}
