import 'package:flutter/scheduler.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/utils/rnd.dart';

class AnimatedCloudStack extends StatefulWidget {
  @override
  State<AnimatedCloudStack> createState() => _AnimatedCloudStackState();
}

class _AnimatedCloudStackState extends State<AnimatedCloudStack> {
  late final Ticker _ticker = Ticker(_tick);

  final List<_CloudState> _clouds = [];

  @override
  void initState() {
    super.initState();
    for (var i = 4; i-- > 0;) {
      final cloud = _CloudState.random();
      cloud.pos -= Offset(i * rnd.getDouble(300, 350), 0);
      _clouds.add(cloud);
    }
    _ticker.start();
  }

  void _tick(Duration _) {
    for (var c in _clouds) {
      c.tick();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _clouds
          .map((c) => Positioned(
                left: c.pos.dx,
                top: c.pos.dy,
                child: Transform.scale(
                  scaleX: c.scale * (c.flipX ? -1 : 1),
                  scaleY: c.scale * (c.flipY ? -1 : 1),
                  child: Opacity(
                      opacity: .7, child: SizedBox(height: 60, child: Image.asset('assets/images/cloud-white.png'))),
                ),
              ))
          .toList(),
    );
  }
}

class _CloudState {
  _CloudState({this.flipX = false, this.flipY = false, required this.pos, this.scale = 1, this.speed = 1});
  final bool flipX;
  final bool flipY;
  Offset pos;
  final double scale;
  final double speed;

  void tick() {
    pos -= Offset(speed * -.25, 0);
  }

  factory _CloudState.random() {
    return _CloudState(
      pos: Offset(0, rnd.getDouble(50, 350)),
      flipX: rnd.getBool(),
      flipY: rnd.getBool(),
      scale: rnd.getDouble(.75, 1.5),
      speed: rnd.getDouble(.5, 1.5),
    );
  }
}
