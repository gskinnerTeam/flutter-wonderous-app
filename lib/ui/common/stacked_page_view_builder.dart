import 'package:wonders/common_libs.dart';

/// Decouples the scrollable area from the size of the PageView itself.
/// Helps simplify the layout of the underlying view and can create a better UX with screen-readers.
///
/// Internally it creates a stack with an invisible PageView on the bottom to handle scrolling,
/// then drives a second PageController (follower) which is passed to the `builder` so a nested PageView can
/// be created to hold the content itself.
///
/// Scrolling of the nested PageView will then be driven by the outer one.
///
class StackedPageViewBuilder extends StatefulWidget {
  const StackedPageViewBuilder({
    super.key,
    this.initialIndex = 0,
    required this.pageCount,
    required this.builder,
    this.onInit,
  });
  final int initialIndex;
  final int pageCount;
  final Widget Function(BuildContext builder, PageController controller, PageController follower) builder;
  final void Function(PageController controller, PageController follower)? onInit;
  @override
  State<StackedPageViewBuilder> createState() => _StackedPageViewBuilderState();
}

class _StackedPageViewBuilderState extends State<StackedPageViewBuilder> {
  late final _controller = PageController(initialPage: widget.initialIndex);
  late final _follower = PageController(initialPage: widget.initialIndex);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleControllerChanged);
    widget.onInit?.call(_controller, _follower);
  }

  @override
  void dispose() {
    _controller.dispose();
    _follower.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ExcludeSemantics(
            child: PageView.builder(
              itemCount: widget.pageCount,
              controller: _controller,
              itemBuilder: (_, __) => Container(color: Colors.transparent),
            ),
          ),
        ),
        widget.builder(context, _controller, _follower),
      ],
    );
  }

  void _handleControllerChanged() => _follower.jumpTo(_controller.position.pixels);
}
