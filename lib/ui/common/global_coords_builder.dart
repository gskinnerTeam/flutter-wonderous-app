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

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _updateOffset());
  }

  void _updateOffset() {
    final context = _key.currentContext;
    if (context != null) {
      final RenderBox? box = context.findRenderObject() as RenderBox?;
      if (box != null && box.hasSize && mounted) {
        Offset newOffset = box.localToGlobal(Offset.zero);
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
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        _updateOffset();
        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Update on layout changes too
          WidgetsBinding.instance.addPostFrameCallback((_) => _updateOffset());
          return Container(
            key: _key,
            constraints: constraints,
            child: Builder(
              builder: (context) => widget.builder(context, _globalOffset, _size),
            ),
          );
        },
      ),
    );
  }
}
