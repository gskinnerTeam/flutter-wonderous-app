import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/blend_mask.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/range_selector.dart';

// Expandable timerange selector component that further refines Artifact Search based on date range.
class ExpandingTimeRangeSelector extends StatefulWidget {
  const ExpandingTimeRangeSelector({
    Key? key,
    required this.wonderType,
    required this.startYr,
    required this.endYr,
    required this.onChanged,
    required this.location,
  }) : super(key: key);
  final WonderType wonderType;
  final int startYr;
  final int endYr;
  final String location;
  final void Function(int start, int end) onChanged;

  @override
  State<ExpandingTimeRangeSelector> createState() => _ExpandingTimeRangeSelectorState();
}

class _ExpandingTimeRangeSelectorState extends State<ExpandingTimeRangeSelector> {
  bool _isPanelOpen = false;
  int _startYrSelected = 0;
  int _endYrSelected = 0;
  String _title = 'Custom';

  @override
  void initState() {
    super.initState();
    _startYrSelected = widget.startYr;
    _endYrSelected = widget.endYr;

    _handleCustomToggle(active: false);
  }

  void _handleYearRangeUpdate(double start, double end) {
    int yearDif = widget.endYr - widget.startYr;
    _startYrSelected = widget.startYr + (yearDif.toDouble() * start).toInt();
    _endYrSelected = widget.startYr + (yearDif.toDouble() * end).toInt();
    setState(() {
      _title = 'Custom';
    });
  }

  void _handleYearRangeChange(double start, double end) {
    int yearDif = widget.endYr - widget.startYr;
    _startYrSelected = widget.startYr + (yearDif.toDouble() * start).toInt();
    _endYrSelected = widget.startYr + (yearDif.toDouble() * end).toInt();
    setState(() {
      _title = 'Custom';
    });

    widget.onChanged(_startYrSelected, _endYrSelected);
  }

  void _handleCustomToggle({bool active = true}) {
    final wonderData = wondersLogic.getData(widget.wonderType);
    if (!active) {
      _startYrSelected = wonderData.startYr;
      _endYrSelected = wonderData.endYr;
    }

    setState(() {
      _title = active ? 'Custom' : wonderData.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.insets.md;

    return LayoutBuilder(builder: (_, constraints) {
      return GestureDetector(
        onTap: () => setState(() => _isPanelOpen = !_isPanelOpen),
        child: AnimatedPadding(
          duration: context.times.fast,
          curve: Curves.easeOut,
          padding: _isPanelOpen ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: context.insets.lg),
          child: OpeningGlassCard(
            isOpen: _isPanelOpen,
            closedBuilder: (_) => Padding(
              padding: EdgeInsets.all(padding),
              child: _ClosedTimeRange(this, _title),
            ),
            openBuilder: (_) => Container(
              color: context.colors.offWhite.withOpacity(0.75),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: SizedBox(
                  width: constraints.maxWidth - padding * 2,
                  child: _OpenedTimeRange(
                    this,
                    _handleYearRangeUpdate,
                    _handleYearRangeChange,
                    () => _handleCustomToggle(active: _title == 'Custom'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

/// Shows the opened timeline view
class _OpenedTimeRange extends StatelessWidget {
  const _OpenedTimeRange(this.state, this.onRangeUpdate, this.onRangeChange, this.onToggleTap, {Key? key})
      : super(key: key);
  final _ExpandingTimeRangeSelectorState state;
  final void Function(double start, double end) onRangeUpdate;
  final void Function(double start, double end) onRangeChange;
  final void Function() onToggleTap;

  @override
  Widget build(BuildContext context) {
    List<Widget> _timelineGrid =
        List.generate(5, (_) => Container(width: 1, color: context.colors.body.withOpacity(0.15)));
    double startRange = (state._startYrSelected - state.widget.startYr) / (state.widget.endYr - state.widget.startYr);
    double endRange = (state._endYrSelected - state.widget.startYr) / (state.widget.endYr - state.widget.startYr);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.insets.xs),
      child: Column(
        children: [
          Text('Choose a timeframe', style: context.textStyles.title3.copyWith(color: context.colors.greyStrong)),
          Gap(context.insets.sm),
          Stack(children: [
            // Background cutout mask for the tile slider
            BlendMask(
              blendModes: const [BlendMode.dstOut],
              opacity: 0.8,
              child: Container(
                width: double.infinity,
                height: 86,
                decoration: BoxDecoration(
                    color: context.colors.white, borderRadius: BorderRadius.all(Radius.circular(context.corners.md))),
              ),
            ),
            // Time slider
            Container(
              width: double.infinity,
              height: 86,
              decoration: BoxDecoration(
                  color: context.colors.offWhite, borderRadius: BorderRadius.all(Radius.circular(context.corners.md))),
            ),
            // Grid container
            Container(
              width: double.infinity,
              height: 86,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(context.corners.md))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _timelineGrid,
              ),
            ),
            // Time slider
            SizedBox(
              width: double.infinity,
              height: 86,
              child: RangeSelector(
                start: startRange,
                end: endRange,
                onUpdated: onRangeUpdate,
                onChanged: onRangeChange,
              ),
            ),
          ]),

          // Year range text.
          Gap(context.insets.lg),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(state._startYrSelected.toString(),
                style: context.textStyles.body3.copyWith(color: context.colors.greyStrong)),
            Gap(context.insets.xxs),
            Text(state._startYrSelected >= 0 ? 'AD' : 'BC',
                style: context.textStyles.tab.copyWith(color: context.colors.caption)),
            Gap(context.insets.xs),
            Text('-', style: context.textStyles.tab.copyWith(color: context.colors.caption)),
            Gap(context.insets.xs),
            Text(state._endYrSelected.toString(),
                style: context.textStyles.body3.copyWith(color: context.colors.greyStrong)),
            Gap(context.insets.xxs),
            Text(state._endYrSelected >= 0 ? 'AD' : 'BC',
                style: context.textStyles.tab.copyWith(color: context.colors.caption)),
          ]),

          // Toggle switch - TODO: Build it!
          /*
            GestureDetector(
              onTap: onToggleTap,
              child: Stack(
                children: [
                  BlendMask(
                    blendModes: const [BlendMode.dstOut],
                    opacity: 0.8,
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          color: context.colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  LabelledToggle(
                      width: 100,
                      height: 50,
                      optionOff: 'Left side',
                      optionOn: 'Right side',
                      isOn: false,
                      handleClick: onToggleTap),
                ],
              ),
            ),
            Gap(context.insets.xs),
            */
        ],
      ),
    );
  }
}

class _ClosedTimeRange extends StatelessWidget {
  const _ClosedTimeRange(this.state, this.title, {Key? key}) : super(key: key);
  final _ExpandingTimeRangeSelectorState state;
  final String title;

  @override
  Widget build(BuildContext context) =>
      Text('${state._startYrSelected} - ${state._endYrSelected} AD - $title', style: context.textStyles.titleFont);
}

class CardHolePainter extends CustomPainter {
  CardHolePainter(this.color, {Key? key});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRRect(RRect.fromLTRBR(100, 100, 300, 300, Radius.circular(10))),
        Path()
          ..addOval(Rect.fromCircle(center: Offset(200, 200), radius: 50))
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
