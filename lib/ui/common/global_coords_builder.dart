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

  void _scheduleUpdate() {
    if (_pendingUpdate) return;
    _pendingUpdate = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _pendingUpdate = false;
      _updateOffset();
    });
  }

  void _updateOffset() {
    final context = _key.currentContext;
    if (context != null) {
      final RenderBox? box = context.findRenderObject() as RenderBox?;
      if (box != null && box.hasSize && mounted) {
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
