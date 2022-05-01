import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';
import 'package:wonders/ui/common/wonders_timeline_builder.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_screen.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/range_selector.dart';

/// TODO: GDS: Clean code up.

// Expandable timerange selector component that further refines Artifact Search based on date range.
class ExpandingTimeRangeSelector extends StatefulWidget {
  const ExpandingTimeRangeSelector({
    Key? key,
    required this.wonder,
    required this.startYear,
    required this.endYear,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);
  final WonderData wonder;
  final double startYear;
  final double endYear;
  final void Function(double start, double end) onChanged;
  final PanelController controller;

  @override
  State<ExpandingTimeRangeSelector> createState() => _ExpandingTimeRangeSelectorState();
}

class _ExpandingTimeRangeSelectorState extends State<ExpandingTimeRangeSelector> {
  @override
  void initState() {
    PanelController controller = widget.controller;
    controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double pad = context.insets.sm;
    final bool isOpen = widget.controller.value;
    return LayoutBuilder(builder: (_, constraints) {
      return GestureDetector(
        onTap: widget.controller.toggle,
        child: Stack(
          children: [
            BottomCenter(
              child: AnimatedPadding(
                duration: context.times.fast,
                curve: Curves.easeOut,
                padding: isOpen ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: context.insets.md),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.white.withOpacity(.65),
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
                    isOpen: isOpen,
                    padding: EdgeInsets.all(pad),
                    closedBuilder: (_) => _ClosedTimeRange(startYear: widget.startYear, endYear: widget.endYear),
                    openBuilder: (_) => SizedBox(
                      width: constraints.maxWidth - pad * 2,
                      child: _OpenedTimeRange(
                        startYear: widget.startYear,
                        endYear: widget.endYear,
                        onChange: widget.onChanged,
                        wonder: widget.wonder,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

/// Shows the opened timeline view
class _OpenedTimeRange extends StatelessWidget {
  const _OpenedTimeRange({
    Key? key,
    required this.onChange,
    required this.startYear,
    required this.endYear,
    required this.wonder,
  }) : super(key: key);
  final double startYear;
  final double endYear;
  final void Function(double start, double end) onChange;
  final WonderData wonder;

  @override
  Widget build(BuildContext context) {
    List<Widget> _timelineGrid =
        List.generate(5, (_) => Container(width: 1, color: context.colors.black.withOpacity(0.1)));

    final headingTextStyle = context.textStyles.h3.copyWith(color: context.colors.greyStrong);
    final captionTextStyle = context.text.bodySmall;

    final startYr = startYear.round(), endYr = endYear.round();

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: context.insets.lg,
              child: Icon(Icons.close, color: context.colors.caption, size: context.insets.md),
            ),
            Spacer(),
            Text(startYr.abs().toString(), style: headingTextStyle),
            Gap(context.insets.xxs),
            Text(StringUtils.getYrSuffix(startYr), style: captionTextStyle),
            Gap(context.insets.xs),
            Text('—', style: captionTextStyle),
            Gap(context.insets.xs),
            Text(endYr.abs().toString(), style: headingTextStyle),
            Gap(context.insets.xxs),
            Text(StringUtils.getYrSuffix(endYr.round()), style: captionTextStyle),
            Spacer(),
            Gap(context.insets.lg),
          ],
        ),

        Gap(context.insets.sm),

        // Timeframe slider
        SizedBox(
          height: 86,
          child: Stack(children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: RangeSelector.handleWidth, vertical: context.insets.sm),
                child: WondersTimelineBuilder(
                  crossAxisGap: 8,
                  minSize: 16,
                  selectedWonders: [wonder.type],
                  timelineBuilder: (_, __, sel) => Container(
                    decoration: BoxDecoration(
                      color: context.colors.black.withOpacity(sel ? 0.4 : 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ),

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
                key: ValueKey('RangeSelectorIsWonderTime'),
                min: wondersLogic.startYear * 1.0,
                max: wondersLogic.endYear * 1.0,
                minDelta: 500,
                start: startYear,
                end: endYear,
                onUpdated: onChange,
              ),
            ),
          ]),
        ),

        Gap(context.insets.md),
      ],
    );
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
    final String text =
        'Time range: ${StringUtils.formatYr(startYear.round())} - ${StringUtils.formatYr(endYear.round())}';

    return Row(
      children: [
        Text(text, style: context.textStyles.titleFont),
        Gap(context.insets.xs),
        Icon(Icons.edit_outlined, color: context.colors.greyStrong, size: 14.0),
      ],
    );
  }
}
