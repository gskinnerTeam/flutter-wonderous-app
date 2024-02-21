import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/opening_card.dart';
import 'package:wonders/ui/common/wonders_timeline_builder.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_screen.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/range_selector.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/time_range_painter.dart';

// Expandable timerange selector component that further refines Artifact Search based on date range.
class ExpandingTimeRangeSelector extends StatefulWidget {
  const ExpandingTimeRangeSelector({
    super.key,
    required this.wonder,
    required this.startYear,
    required this.endYear,
    required this.onChanged,
    required this.panelController,
    required this.vizController,
  });
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
    double safeBottom = max($styles.insets.md, MediaQuery.of(context).padding.bottom);

    return LayoutBuilder(builder: (_, constraints) {
      return BottomCenter(
        child: AnimatedPadding(
          duration: $styles.times.fast,
          padding: isOpen ? EdgeInsets.zero : EdgeInsets.only(bottom: safeBottom + $styles.insets.xxs),
          child: AppBtn.basic(
            onPressed: () => widget.panelController.toggle(),
            semanticLabel: '',
            pressEffect: false,
            child: OpeningCard(
              isOpen: isOpen,
              padding: EdgeInsets.symmetric(horizontal: pad, vertical: $styles.insets.xs),
              background: Container(
                decoration: BoxDecoration(
                  color: $styles.colors.black.withOpacity(0.85),
                  borderRadius: BorderRadius.circular($styles.corners.md),
                  boxShadow: [
                    BoxShadow(
                      color: $styles.colors.black.withOpacity(0.66),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ],
                ),
              ),
              closedBuilder: (_) => _ClosedTimeRange(startYear: widget.startYear, endYear: widget.endYear),
              openBuilder: (_) => SizedBox(
                width: constraints.maxWidth - pad * 2,
                child: Center(
                  child: _OpenedTimeRange(
                    startYear: widget.startYear,
                    endYear: widget.endYear,
                    onChange: widget.onChanged,
                    wonder: widget.wonder,
                    painter: _painter,
                    onClose: widget.panelController.toggle,
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

class _ClosedTimeRange extends StatelessWidget {
  const _ClosedTimeRange({
    required this.startYear,
    required this.endYear,
  });
  final double startYear, endYear;

  @override
  Widget build(BuildContext context) {
    final String text = '${StringUtils.formatYr(startYear.round())} - ${StringUtils.formatYr(endYear.round())}';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: $styles.insets.xs),
      child: Row(
        children: [
          Text(text, style: $styles.text.title2.copyWith(color: $styles.colors.offWhite)),
          Gap($styles.insets.xs),
          Icon(Icons.edit_calendar_outlined, color: $styles.colors.accent1, size: $styles.insets.md),
        ],
      ),
    );
  }
}

class _OpenedTimeRange extends StatelessWidget {
  const _OpenedTimeRange({
    required this.onChange,
    required this.startYear,
    required this.endYear,
    required this.wonder,
    required this.painter,
    required this.onClose,
  });
  final double startYear;
  final double endYear;
  final void Function(double start, double end) onChange;
  final WonderData wonder;
  final TimeRangePainter painter;
  final void Function() onClose;

  List<Widget> _buildChineseDateLayout(TextStyle headingTextStyle, TextStyle captionTextStyle, int startYr, int endYr) {
    return [
      Text(StringUtils.getYrSuffix(startYr), style: captionTextStyle),
      Gap($styles.insets.xxs),
      Text(startYr.abs().toString(), style: headingTextStyle),
      Text($strings.year, style: captionTextStyle),
      Gap($styles.insets.xs),
      Text('~', style: captionTextStyle),
      Gap($styles.insets.xs),
      Text(StringUtils.getYrSuffix(endYr.round()), style: captionTextStyle),
      Gap($styles.insets.xxs),
      Text(endYr.abs().toString(), style: headingTextStyle),
      Text($strings.year, style: captionTextStyle),
    ];
  }

  List<Widget> _buildDefaultDateLayout(TextStyle headingTextStyle, TextStyle captionTextStyle, int startYr, int endYr) {
    return [
      Text(startYr.abs().toString(), style: headingTextStyle),
      Gap($styles.insets.xxs),
      Text(StringUtils.getYrSuffix(startYr), style: captionTextStyle),
      Gap($styles.insets.xs),
      Text('—', style: captionTextStyle),
      Gap($styles.insets.xs),
      Text(endYr.abs().toString(), style: headingTextStyle),
      Gap($styles.insets.xxs),
      Text(StringUtils.getYrSuffix(endYr.round()), style: captionTextStyle),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double safeBottom = max($styles.insets.sm, MediaQuery.of(context).padding.bottom);
    List<Widget> timelineGrid = List.generate(5, (_) => Container(width: 1, color: $styles.colors.black));

    final headingTextStyle = $styles.text.title1.copyWith(color: $styles.colors.offWhite, fontSize: 20 * $styles.scale);
    final captionTextStyle = $styles.text.bodySmall.copyWith(color: $styles.colors.greyMedium);

    final startYr = startYear.round(), endYr = endYear.round();

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap($styles.insets.xl),
            Spacer(),
            if (localeLogic.strings.localeName == 'zh') ...{
              ..._buildChineseDateLayout(headingTextStyle, captionTextStyle, startYr, endYr),
            } else ...{
              ..._buildDefaultDateLayout(headingTextStyle, captionTextStyle, startYr, endYr),
            },
            Spacer(),
            SizedBox(
              width: $styles.insets.xl,
              child: AppBtn.from(
                onPressed: onClose,
                semanticLabel: $strings.expandingTimeSelectorSemanticSelector,
                enableFeedback: false, // handled when panelController changes.
                icon: AppIcons.close,
                iconSize: 20,
                padding: EdgeInsets.symmetric(vertical: $styles.insets.xxs),
                bgColor: Colors.transparent,
              ),
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
                child: RepaintBoundary(
                  child: CustomPaint(painter: painter),
                ),
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

        Gap(safeBottom),
      ],
    );
  }
}
