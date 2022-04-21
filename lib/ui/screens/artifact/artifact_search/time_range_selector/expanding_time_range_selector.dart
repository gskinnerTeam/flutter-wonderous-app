import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/blend_mask.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/labelled_toggle.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/range_selector.dart';
import 'dart:math' as math;

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

  // Determines either if in custom year select mode or locked on artifact start/end year mode.
  bool isWonderTimeframe = false;

  // The start and end year range on the selector.
  int startYrRange = 0;
  int endYrRange = 0;

  // The currently set start and end year.
  int startYrCustom = 0;
  int endYrCustom = 0;

  @override
  void initState() {
    super.initState();
    final wonderData = wondersLogic.getData(widget.wonderType);

    // Artifact dates can span beyond the range selector. Move the range if needed.
    startYrRange = math.min(wonderData.artifactStartYr, widget.startYr);
    endYrRange = math.max(wonderData.artifactEndYr, widget.endYr);

    // Initialize the custom start/end year with the max/min.
    startYrCustom = startYrRange;
    endYrCustom = endYrRange;

    _handleCustomToggle(isWonderTime: true);
  }

  void _handleYearRangeUpdate(double start, double end) {
    // User currently sliding the range slider. Update the custom year and ensure it's in custom mode, but don't dispatch change call yet.
    int yearDif = endYrRange - startYrRange;
    startYrCustom = startYrRange + (yearDif.toDouble() * start).toInt();
    endYrCustom = startYrRange + (yearDif.toDouble() * end).toInt();
    setState(() {
      isWonderTimeframe = false;
    });
  }

  void _handleYearRangeChange(double start, double end) {
    // User changed year and released the slider. Dispatch event to search.
    _handleYearRangeUpdate(start, end);
    widget.onChanged(startYrCustom, endYrCustom);
  }

  void _handleCustomToggle({bool isWonderTime = true}) {
    // User toggled the custom switch. Switch between modes and trigger change in search.
    if (isWonderTime) {
      final wonderData = wondersLogic.getData(widget.wonderType);
      widget.onChanged(wonderData.artifactStartYr, wonderData.artifactEndYr);
    } else {
      widget.onChanged(startYrCustom, endYrCustom);
    }

    setState(() {
      isWonderTimeframe = isWonderTime;
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
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.all(Radius.circular(context.corners.md)),
              boxShadow: [
                BoxShadow(color: context.colors.black.withOpacity(0.25), offset: Offset(0, 4), blurRadius: 4)
              ],
            ),
            child: OpeningGlassCard(
              isOpen: _isPanelOpen,
              closedBuilder: (_) => Padding(
                padding: EdgeInsets.all(padding),
                child: _ClosedTimeRange(this),
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
                      () => _handleCustomToggle(isWonderTime: !isWonderTimeframe),
                    ),
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
    final wonderData = wondersLogic.getData(state.widget.wonderType);
    List<Widget> _timelineGrid =
        List.generate(5, (_) => Container(width: 1, color: context.colors.body.withOpacity(0.15)));

    int startYr = state.isWonderTimeframe ? wonderData.artifactStartYr : state.startYrCustom;
    int endYr = state.isWonderTimeframe ? wonderData.artifactEndYr : state.endYrCustom;

    double startSliderRange = (startYr - wonderData.artifactStartYr) / (state.endYrRange - state.startYrRange);
    double endSliderRange = (endYr - wonderData.artifactStartYr) / (state.endYrRange - state.startYrRange);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.insets.xs),
      child: Column(
        children: [
          Text('Choose a timeframe', style: context.textStyles.title3.copyWith(color: context.colors.greyStrong)),
          Gap(context.insets.sm),

          // Timeframe slider
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
            // Time slider background
            Container(
              width: double.infinity,
              height: 86,
              decoration: BoxDecoration(
                  color: context.colors.offWhite, borderRadius: BorderRadius.all(Radius.circular(context.corners.md))),
            ),
            // Grid lines container
            Container(
              width: double.infinity,
              height: 86,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(context.corners.md))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _timelineGrid,
              ),
            ),
            // Time slider itself
            SizedBox(
              width: double.infinity,
              height: 86,
              child: RangeSelector(
                key: ValueKey(Random().getDouble(-double.maxFinite, double.maxFinite)),
                start: startSliderRange,
                end: endSliderRange,
                onUpdated: onRangeUpdate,
                onChanged: onRangeChange,
              ),
            ),
          ]),

          // Year range text.
          Gap(context.insets.lg),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(startYr.abs().toString(), style: context.textStyles.body3.copyWith(color: context.colors.greyStrong)),
            Gap(context.insets.xxs),
            Text(startYr >= 0 ? 'AD' : 'BC', style: context.textStyles.tab.copyWith(color: context.colors.caption)),
            Gap(context.insets.xs),
            Text('-', style: context.textStyles.tab.copyWith(color: context.colors.caption)),
            Gap(context.insets.xs),
            Text(endYr.abs().toString(), style: context.textStyles.body3.copyWith(color: context.colors.greyStrong)),
            Gap(context.insets.xxs),
            Text(endYr >= 0 ? 'AD' : 'BC', style: context.textStyles.tab.copyWith(color: context.colors.caption)),
          ]),

          Gap(context.insets.md),
          LabelledToggle(
              optionOff: 'Custom', optionOn: wonderData.title, isOn: state.isWonderTimeframe, onClick: onToggleTap),
          Gap(context.insets.xs),
        ],
      ),
    );
  }
}

class _ClosedTimeRange extends StatelessWidget {
  const _ClosedTimeRange(this.state, {Key? key}) : super(key: key);
  final _ExpandingTimeRangeSelectorState state;

  @override
  Widget build(BuildContext context) {
    final wonderData = wondersLogic.getData(state.widget.wonderType);
    String text = 'Timeframe:: ${state.startYrCustom} - ${state.endYrCustom} AD';
    if (state.isWonderTimeframe) {
      text = 'Timeframe: ' + wonderData.title;
    }
    return Text(text, style: context.textStyles.titleFont);
  }
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
