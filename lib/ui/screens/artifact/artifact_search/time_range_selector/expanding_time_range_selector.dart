import 'package:wonders/common_libs.dart';
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

  int startYrSelected = 0;
  int endYrSelected = 0;
  String title = 'Custom';

  @override
  void initState() {
    super.initState();
    startYrSelected = widget.startYr;
    endYrSelected = widget.endYr;

    final wonderData = wondersLogic.getDataForType(widget.wonderType);
    _handleCustomToggle(active: false);
  }

  void _handleYearRangeChange(double start, double end) {
    int yearDif = widget.endYr - widget.startYr;
    setState(() {
      startYrSelected = widget.startYr + (yearDif.toDouble() * start).toInt();
      endYrSelected = widget.startYr + (yearDif.toDouble() * end).toInt();
      title = 'Custom';
    });
  }

  void _handleCustomToggle({bool active = true}) {
    final wonderData = wondersLogic.getDataForType(widget.wonderType);
    if (!active) {
      startYrSelected = wonderData.startYr;
      endYrSelected = wonderData.endYr;
    }

    setState(() {
      title = active ? 'Custom' : wonderData.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wonderData = wondersLogic.getDataForType(widget.wonderType);
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
            padding: EdgeInsets.all(padding),
            closedBuilder: (_) => _ClosedTimeRange(this, title),
            openBuilder: (_) => SizedBox(
                width: constraints.maxWidth - padding * 2, child: _OpenedTimeRange(this, _handleYearRangeChange)),
          ),
        ),
      );
    });
  }
}

/// Shows the opened timeline view
class _OpenedTimeRange extends StatelessWidget {
  const _OpenedTimeRange(this.state, this.handleRangeChange, {Key? key}) : super(key: key);
  final _ExpandingTimeRangeSelectorState state;
  final void Function(double start, double end) handleRangeChange;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: context.insets.xs),
        child: Column(
          children: [
            Text('Choose a timeframe',
                style: context.textStyles.title3.copyWith(fontSize: 16, color: context.colors.greyStrong)),
            Gap(context.insets.sm),
            Stack(children: [
              Container(
                  width: double.infinity,
                  height: 86,
                  //decoration: BoxDecoration(backgroundBlendMode: BlendMode.colorBurn, color: context.colors.bg),
                  child: RangeSelector(
                      start:
                          (state.startYrSelected - state.widget.startYr) / (state.widget.endYr - state.widget.startYr),
                      end: (state.endYrSelected - state.widget.startYr) / (state.widget.endYr - state.widget.startYr),
                      onChanged: handleRangeChange)),
            ]),
            Gap(context.insets.lg),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(state.startYrSelected.toString(),
                  style: context.textStyles.body3.copyWith(color: context.colors.greyStrong)),
              Gap(context.insets.xxs),
              Text(state.startYrSelected >= 0 ? 'AD' : 'BC',
                  style: context.textStyles.tab.copyWith(color: context.colors.caption)),
              Gap(context.insets.xs),
              Text('-', style: context.textStyles.tab.copyWith(color: context.colors.caption)),
              Gap(context.insets.xs),
              Text(state.endYrSelected.toString(),
                  style: context.textStyles.body3.copyWith(color: context.colors.greyStrong)),
              Gap(context.insets.xxs),
              Text(state.endYrSelected >= 0 ? 'AD' : 'BC',
                  style: context.textStyles.tab.copyWith(color: context.colors.caption)),
            ]),
            Gap(context.insets.xs),
          ],
        ),
      );
}

class _ClosedTimeRange extends StatelessWidget {
  const _ClosedTimeRange(this.state, this.title, {Key? key}) : super(key: key);
  final _ExpandingTimeRangeSelectorState state;
  final String title;

  @override
  Widget build(BuildContext context) =>
      Text('${state.startYrSelected} - ${state.endYrSelected} AD - $title', style: context.textStyles.titleFont);
}
