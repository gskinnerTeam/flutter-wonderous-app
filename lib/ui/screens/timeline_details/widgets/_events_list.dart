part of '../timeline_details.dart';

class _EventsList extends StatefulWidget {
  const _EventsList({Key? key, required this.data}) : super(key: key);
  final WonderData data;

  @override
  State<_EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<_EventsList> {
  late final ScrollController _scroller = ScrollController()..addListener(_handleScrollChanged);
  bool _hasPopped = false;
  bool _isPointerDown = false;
  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  void _handleScrollChanged() {
    if (!_isPointerDown) return;
    if (_scroller.position.pixels < -100 && !_hasPopped) {
      _hasPopped = true;
      context.pop();
    }
  }

  bool _checkPointerIsDown(d) => _isPointerDown = d.dragDetails != null;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: _checkPointerIsDown,
      child: LayoutBuilder(builder: (_, constraints) {
        return Stack(
          children: [
            AnimatedBuilder(
              animation: _scroller,
              builder: (_, __) {
                double blur = 0;
                double scrollAmt = 0;
                if (_scroller.hasClients) {
                  double blurStart = 100;
                  scrollAmt = (_scroller.position.pixels - blurStart).clamp(0, 50) / 50;
                  blur = scrollAmt * 10;
                }
                // Container provides a underlay which gets darker as the background blurs
                return Container(
                  color: context.colors.greyStrong.withOpacity(min(1, scrollAmt * 2) * .5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                    child: _buildScrollingList(),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _buildScrollingList() {
    Container buildHandle() {
      return Container(
        width: 35,
        height: 5,
        decoration: BoxDecoration(color: context.colors.greyMedium, borderRadius: BorderRadius.circular(99)),
      );
    }

    final events = widget.data.events;

    final listItems = <Widget>[];
    for (var e in events.entries) {
      final delay = 100.ms + (100 * listItems.length).ms;
      listItems.add(
        _EventListItem(year: e.key, text: e.value)
            .fx()
            .fade(delay: delay, duration: context.times.med * 1.5)
            .slide(begin: Offset(0, 1), curve: Curves.easeOutBack),
      );
    }
    return SingleChildScrollView(
      controller: _scroller,
      child: Column(
        children: [
          Gap(TimelineDetails._topHeight),
          Container(
            decoration: BoxDecoration(
              color: context.colors.white,
              borderRadius: BorderRadius.circular(context.corners.md),
            ),
            padding: EdgeInsets.symmetric(horizontal: context.insets.md),
            child: Column(
              children: [
                Gap(context.insets.xs),
                buildHandle(),
                Gap(context.insets.sm),
                ...listItems,
                HiddenCollectible(widget.data.type, index: 2, size: 150),
                Gap(200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventListItem extends StatelessWidget {
  const _EventListItem({Key? key, required this.year, required this.text}) : super(key: key);
  final int year;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.insets.sm),
      child: Container(
        color: context.colors.offWhite,
        padding: EdgeInsets.all(context.insets.sm),
        child: Row(
          children: [
            SizedBox(
              width: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$year', style: context.text.h3.copyWith(fontWeight: FontWeight.w400, height: 1)),
                  Text(StringUtils.getYrSuffix(year), style: context.text.bodySmall),
                ],
              ),
            ),
            Center(child: Container(width: 1, height: 50, color: context.colors.black)),
            Gap(context.insets.sm),
            Expanded(
              child: Text(text, style: context.text.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
