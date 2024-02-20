part of '../collection_screen.dart';

@immutable
class _CollectionList extends StatefulWidget with GetItStatefulWidgetMixin {
  _CollectionList({
    super.key,
    this.onReset,
    required this.fromId,
    this.scrollKey,
  });

  static const double _vtCardExtent = 300;
  static const double _hzCardExtent = 600;
  final VoidCallback? onReset;
  final Key? scrollKey;
  final String fromId;

  @override
  State<_CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<_CollectionList> with GetItStateMixin {
  final ScrollController scrollController = ScrollController();

  late final ValueNotifier<bool> _vtMode = ValueNotifier(true)..addListener(_maintainScrollPos);

  WonderType? get scrollTargetWonder {
    CollectibleData? item;
    if (widget.fromId.isEmpty) {
      item = collectiblesLogic.getFirstDiscoveredOrNull();
    } else {
      item = collectiblesLogic.fromId(widget.fromId);
    }
    return item?.wonder;
  }

  // Maintain scroll position when switching between vertical and horizontal orientation.
  // Multiplies or divides the current scroll position by the ratio of the vertical and horizontal card extents.
  void _maintainScrollPos() {
    if (scrollController.hasClients == false) return;
    const extentFactor = _CollectionList._vtCardExtent / _CollectionList._hzCardExtent;
    final currentPx = scrollController.position.pixels;
    if (_vtMode.value == true) {
      scrollController.jumpTo(currentPx * extentFactor);
    } else {
      scrollController.jumpTo(currentPx / extentFactor);
    }
  }

  @override
  Widget build(BuildContext context) {
    watchX((CollectiblesLogic o) => o.statesById);
    List<WonderData> wonders = wondersLogic.all;
    _vtMode.value = context.isLandscape == false;
    final scrollWonder = scrollTargetWonder;
    // Create list of collections that is shared by both hz and vt layouts
    List<Widget> collections = [
      ...wonders.map((d) {
        return _CollectionListCard(
          key: d.type == scrollWonder ? widget.scrollKey : null,
          width: _vtMode.value ? null : _CollectionList._hzCardExtent,
          height: _vtMode.value ? _CollectionList._vtCardExtent : 400,
          fromId: widget.fromId,
          data: d,
        );
      })
    ];
    // Scroll view adapts to scroll vertically or horizontally
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: _vtMode.value ? Axis.vertical : Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.lg),
        child: SeparatedFlex(
          direction: _vtMode.value ? Axis.vertical : Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          separatorBuilder: () => Gap($styles.insets.lg),
          children: [
            ...collections,
            Gap($styles.insets.sm),
            if (kDebugMode) _buildResetBtn(context),
          ],
        ),
      ),
    );
  }

  Widget _buildResetBtn(BuildContext context) {
    Widget btn = AppBtn.from(
      onPressed: widget.onReset ?? () {},
      text: $strings.collectionButtonReset,
      isSecondary: true,
      expand: true,
    );
    return AnimatedOpacity(opacity: widget.onReset == null ? 0.25 : 1, duration: $styles.times.fast, child: btn);
  }
}
