import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/cards/opening_card.dart';
import 'package:wonders/ui/common/wonders_timeline_builder.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_screen.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/range_selector.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/time_range_painter.dart';

/// TODO: GDS: Clean code up.

// Expandable timerange selector component that further refines Artifact Search based on date range.
class ExpandingTimeRangeSelector extends StatefulWidget {
  const ExpandingTimeRangeSelector({
    Key? key,
    required this.wonder,
    required this.startYear,
    required this.endYear,
    required this.onChanged,
    required this.panelController,
    required this.vizController,
  }) : super(key: key);
  final WonderData wonder;
  final double startYear;
  final double endYear;
  final void Function(double start, double end) onChanged;
  final PanelController panelController;
  final SearchVizController vizController;

  @override
  State<ExpandingTimeRangeSelector> createState() => _ExpandingTimeRangeSelectorState();
}

class _ExpandingTimeRangeSelectorState extends State<ExpandingTimeRangeSelector> {
  late final TimeRangePainter _painter;

  @override
  void initState() {
    widget.panelController.addListener(() => setState(() {}));
    _painter = TimeRangePainter(controller: widget.vizController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double pad = $styles.insets.sm;
    final bool isOpen = widget.panelController.value;
    return LayoutBuilder(builder: (_, constraints) {
      return Stack(
        children: [
          BottomCenter(
            child: AnimatedPadding(
              duration: $styles.times.fast,
              curve: Curves.easeOut,
              padding: isOpen ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: $styles.insets.md),
              child: AppBtn.basic(
                semanticLabel: $strings.expandingTimeSelectorSemanticSelector,
                onPressed: widget.panelController.toggle,
                child: OpeningCard(
                  isOpen: isOpen,
                  padding: EdgeInsets.symmetric(horizontal: pad, vertical: $styles.insets.xs),
                  background: Container(
                    decoration: BoxDecoration(
                      color: $styles.colors.black.withOpacity(0.85),
                      borderRadius: BorderRadius.circular($styles.corners.md),
                      boxShadow: [
                        BoxShadow(
                          color: $styles.colors.black.withOpacity(0.5),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        )
                      ],
                    ),
                  ),
                  closedBuilder: (_) => _ClosedTimeRange(startYear: widget.startYear, endYear: widget.endYear),
                  openBuilder: (_) => SizedBox(
                    width: constraints.maxWidth - pad * 2,
                    child: _OpenedTimeRange(
                      startYear: widget.startYear,
                      endYear: widget.endYear,
                      onChange: widget.onChanged,
                      wonder: widget.wonder,
                      painter: _painter,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _ClosedTimeRange extends StatelessWidget {
  const _ClosedTimeRange({
    Key? key,
    required this.startYear,
    required this.endYear,
  }) : super(key: key);
  final double startYear, endYear;

  @override
  Widget build(BuildContext context) {
    final String text = '${StringUtils.formatYr(startYear.round())} - ${StringUtils.formatYr(endYear.round())}';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: $styles.insets.xs),
      child: Row(
        children: [
          Text(text, style: $styles.text.titleFont.copyWith(color: $styles.colors.offWhite)),
          Gap($styles.insets.xs),
          Icon(Icons.edit_calendar_outlined, color: $styles.colors.accent1, size: $styles.insets.md),
        ],
      ),
    );
  }
}

class _OpenedTimeRange extends StatelessWidget {
  const _OpenedTimeRange({
    Key? key,
    required this.onChange,
    required this.startYear,
    required this.endYear,
    required this.wonder,
    required this.painter,
  }) : super(key: key);
  final double startYear;
  final double endYear;
  final void Function(double start, double end) onChange;
  final WonderData wonder;
  final TimeRangePainter painter;

  @override
  Widget build(BuildContext context) {
    List<Widget> timelineGrid = List.generate(5, (_) => Container(width: 1, color: $styles.colors.black));

    final headingTextStyle = $styles.text.title1.copyWith(color: $styles.colors.offWhite, fontSize: 18);
    final captionTextStyle = $styles.text.bodySmall.copyWith(color: $styles.colors.greyMedium);

    final startYr = startYear.round(), endYr = endYear.round();

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap($styles.insets.lg),
            Spacer(),
            Text(startYr.abs().toString(), style: headingTextStyle),
            Gap($styles.insets.xxs),
            Text(StringUtils.getYrSuffix(startYr), style: captionTextStyle),
            Gap($styles.insets.xs),
            Text('—', style: captionTextStyle),
            Gap($styles.insets.xs),
            Text(endYr.abs().toString(), style: headingTextStyle),
            Gap($styles.insets.xxs),
            Text(StringUtils.getYrSuffix(endYr.round()), style: captionTextStyle),
            Spacer(),
            SizedBox(
              width: $styles.insets.lg,
              child: Icon(Icons.close, color: $styles.colors.caption, size: 20),
            ),
          ],
        ),

        Gap($styles.insets.xs * 1.5),

        // Timeframe slider
        SizedBox(
          height: $styles.insets.lg * 2,
          child: Stack(children: [
            // grid lines:
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular($styles.corners.md),
                color: Color.lerp($styles.colors.black, Colors.black, 0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: timelineGrid,
              ),
            ),

            // results visualization:
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: RangeSelector.handleWidth),
                child: CustomPaint(painter: painter),
              ),
            ),

            // wonder minimap:
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: RangeSelector.handleWidth, vertical: 12),
                child: WondersTimelineBuilder(
                  crossAxisGap: 6,
                  minSize: 16,
                  selectedWonders: [wonder.type],
                  timelineBuilder: (_, __, sel) => Container(
                    decoration: BoxDecoration(
                      color: $styles.colors.offWhite.withOpacity(sel ? 0.75 : 0.25),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ),

            // Time slider itself
            Positioned.fill(
              child: RangeSelector(
                key: ValueKey('RangeSelectorIsWonderTime'),
                min: wondersLogic.timelineStartYear * 1.0,
                max: wondersLogic.timelineEndYear * 1.0,
                minDelta: 500,
                start: startYear,
                end: endYear,
                onUpdated: onChange,
              ),
            ),
          ]),
        ),

        Gap($styles.insets.sm),
      ],
    );
  }
}
