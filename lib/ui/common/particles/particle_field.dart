import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wonders/ui/common/particles/particle.dart';
import 'package:wonders/ui/common/particles/particle_field_painter.dart';
import 'package:wonders/ui/common/particles/sprite_sheet.dart';

export 'particle.dart';
export 'particle_field_painter.dart';
export 'sprite_sheet.dart';

class ParticleField extends StatefulWidget {
  final SpriteSheet spriteSheet;
  final ParticleFieldTick onTick;
  final ParticleFieldInit? onInit;
  final BlendMode blendMode;
  final Alignment alignment;

  const ParticleField({
    required this.spriteSheet,
    required this.onTick,
    this.onInit,
    this.blendMode = BlendMode.dstIn,
    this.alignment = Alignment.center,
    Key? key,
  }) : super(key: key);

  @override
  State<ParticleField> createState() => _ParticleFieldState();
}

class _ParticleFieldState extends State<ParticleField> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  late final ParticleController _controller;
  late final ParticleFieldPainter _painter;

  @override
  void initState() {
    _controller = ParticleController(
      spriteSheet: widget.spriteSheet,
      onTick: widget.onTick,
      onInit: widget.onInit,
      blendMode: widget.blendMode,
      alignment: widget.alignment,
    );
    _painter = ParticleFieldPainter(controller: _controller);
    _ticker = createTicker(_controller.tick)..start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _painter);
  }
}

class ParticleController with ChangeNotifier {
  bool repaint = true;
  SpriteSheet spriteSheet;
  ParticleFieldTick onTick;
  ParticleFieldInit? onInit;
  BlendMode blendMode;
  List<Particle> particles = [];
  Alignment alignment;
  double opacity = 1.0;
  Duration _lastElapsed = Duration.zero;

  ParticleController({
    required this.onTick,
    required this.spriteSheet,
    this.onInit,
    required this.blendMode,
    required this.alignment,
  }) {
    if (onInit != null) onInit!(this);
  }

  void tick(Duration elapsed) {
    // save the elapsed time, and notify the painter.
    _lastElapsed = elapsed;
    notifyListeners();
  }

  void executeOnTick(Size size) {
    // called by the painter in order to get the canvas size cheaply.
    onTick(this, _lastElapsed, size);
  }
}

typedef ParticleFieldTick = void Function(
  ParticleController controller,
  Duration elapsed,
  Size size,
);

typedef ParticleFieldInit = void Function(
  ParticleController controller,
);
