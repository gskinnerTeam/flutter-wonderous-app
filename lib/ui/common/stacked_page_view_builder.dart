import 'package:wonders/common_libs.dart';

/// Eases "full screen" scrolling when using PageView component.
/// Creates a stack with an empty PageView on top to handle scrolling,
/// then passes a child PageController to the `builder` so a child PageView can
/// be created to hold the content itself (which may not want to be fullscreen).
/// The parent PageView will drive the swiping of the child PageView.
class StackedPageViewBuilder extends StatefulWidget {
  const StackedPageViewBuilder({
    Key? key,
    this.initialIndex = 0,
    required this.pageCount,
    required this.builder,
    this.onInit,
  }) : super(key: key);
  final int initialIndex;
  final int pageCount;
  final Widget Function(BuildContext builder, PageController controller) builder;
  final void Function(PageController controller)? onInit;
  @override
  State<StackedPageViewBuilder> createState() => _StackedPageViewBuilderState();
}

class _StackedPageViewBuilderState extends State<StackedPageViewBuilder> {
  late final _parentController = PageController(initialPage: widget.initialIndex);
  late final _childController = PageController(initialPage: widget.initialIndex);

  @override
  void initState() {
    super.initState();
    _parentController.addListener(_handlePageChanged);
    widget.onInit?.call(_parentController);
  }

  @override
  void dispose() {
    _parentController.dispose();
    _childController.dispose();
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
              controller: _parentController,
              itemBuilder: (_, __) => Container(color: Colors.transparent),
            ),
          ),
        ),
        widget.builder(context, _childController),
      ],
    );
  }

  void _handlePageChanged() => _childController.jumpTo(_parentController.position.pixels);
}
