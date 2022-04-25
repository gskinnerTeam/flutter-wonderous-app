import 'package:wonders/common_libs.dart';
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
    final double pad = context.insets.sm;

    return LayoutBuilder(builder: (_, constraints) {
      return GestureDetector(
        onTap: () => setState(() => _isPanelOpen = !_isPanelOpen),
        child: AnimatedPadding(
          duration: context.times.fast,
          curve: Curves.easeOut,
          padding: _isPanelOpen ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: context.insets.md),
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.all(Radius.circular(context.corners.md)),
              boxShadow: [
                BoxShadow(
                  color: context.colors.black.withOpacity(0.25),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: OpeningGlassCard(
              isOpen: _isPanelOpen,
              padding: EdgeInsets.all(pad),
              closedBuilder: (_) => _ClosedTimeRange(this),
              openBuilder: (_) => SizedBox(
                width: constraints.maxWidth - pad * 2,
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
        List.generate(5, (_) => Container(width: 1, color: context.colors.black.withOpacity(0.1)));

    int startYr = state.isWonderTimeframe ? wonderData.artifactStartYr : state.startYrCustom;
    int endYr = state.isWonderTimeframe ? wonderData.artifactEndYr : state.endYrCustom;

    double startSliderRange = (startYr - wonderData.artifactStartYr) / (state.endYrRange - state.startYrRange);
    double endSliderRange = (endYr - wonderData.artifactStartYr) / (state.endYrRange - state.startYrRange);

    return Column(
      children: [
        Text(
          'Choose a timeframe',
          style: context.textStyles.title3.copyWith(color: context.colors.greyStrong),
          textAlign: TextAlign.center,
        ),
        Gap(context.insets.sm),

        // Timeframe slider
        SizedBox(
          height: 86,
          child: Stack(children: [
            // Grid lines container
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.corners.md),
                color: context.colors.black.withOpacity(0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _timelineGrid,
              ),
            ),

            // Time slider itself
            Positioned.fill(
              child: RangeSelector(
                key: ValueKey('RangeSelectorIsWonderTime' + state.isWonderTimeframe.toString()),
                start: startSliderRange,
                end: endSliderRange,
                isLocked: state.isWonderTimeframe,
                onUpdated: onRangeUpdate,
                onChanged: onRangeChange,
              ),
            ),
          ]),
        ),

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
    return Row(
      children: [
        Text(text, style: context.textStyles.titleFont),
        Gap(context.insets.xs),
        Icon(Icons.edit_outlined, color: context.colors.greyStrong, size: 14.0),
      ],
    );
  }
}
