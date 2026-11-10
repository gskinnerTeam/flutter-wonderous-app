import 'package:flutter/scheduler.dart';
import 'package:wonders/common_libs.dart';

class GlobalCoordsBuilder extends StatefulWidget {
  const GlobalCoordsBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, Offset? globalOffset, Size? size) builder;

  @override
  State<GlobalCoordsBuilder> createState() => _GlobalCoordsBuilderState();
}

class _GlobalCoordsBuilderState extends State<GlobalCoordsBuilder> {
  final GlobalKey _key = GlobalKey();
  Offset? _globalOffset;
  Size? _size;
  bool _pendingUpdate = false;

  @override
  void initState() {
    super.initState();
    _scheduleUpdate();
  }

  /// The callers sit inside scroll-driven builders (ValueListenableBuilder / AnimatedBuilder),
  /// so the parent rebuilds on every scroll tick. Ancestor scrolling doesn't bubble a
  /// ScrollNotification down to us, so re-measure here after the frame lays out.
  /// No loop: our own setState calls build(), never didUpdateWidget(), and setState only runs
  /// when the measured value actually changed.
  @override
  void didUpdateWidget(covariant GlobalCoordsBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleUpdate();
  }

  void _scheduleUpdate() {
    if (_pendingUpdate) return;
    _pendingUpdate = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _pendingUpdate = false;
      _updateOffset();
    });
  }

  void _updateOffset() {
    if (!mounted) return;
    final context = _key.currentContext;
    if (context != null) {
      final RenderBox? box = context.findRenderObject() as RenderBox?;
      if (box != null && box.attached && box.hasSize) {
        Offset? newOffset;
        try {
          newOffset = box.localToGlobal(Offset.zero);
        } catch (_) {
          if (_globalOffset != null || _size != null) {
            setState(() {
              _globalOffset = null;
              _size = null;
            });
          }
          return;
        }
        if (_globalOffset != newOffset || _size != box.size) {
          setState(() {
            _globalOffset = newOffset;
            _size = box.size;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) {
        _scheduleUpdate();
        return false;
      },
      child: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (_) {
          _scheduleUpdate();
          return false;
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              key: _key,
              constraints: constraints,
              child: Builder(
                builder: (context) => widget.builder(context, _globalOffset, _size),
              ),
            );
          },
        ),
      ),
    );
  }
}
