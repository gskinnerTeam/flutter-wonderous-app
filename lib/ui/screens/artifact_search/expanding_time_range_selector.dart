import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';

class ExpandingTimeRangeSelector extends StatefulWidget {
  const ExpandingTimeRangeSelector({
    Key? key,
    required this.startYr,
    required this.endYr,
    required this.onChanged,
    required this.location,
  }) : super(key: key);
  final int startYr;
  final int endYr;
  final String location;
  final void Function(int start, int end) onChanged;

  @override
  State<ExpandingTimeRangeSelector> createState() => _ExpandingTimeRangeSelectorState();
}

class _ExpandingTimeRangeSelectorState extends State<ExpandingTimeRangeSelector> {
  bool _isPanelOpen = false;

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
            padding: EdgeInsets.all(padding),
            closedBuilder: (_) => _ClosedTimeRange(this),
            openBuilder: (_) => SizedBox(width: constraints.maxWidth - padding * 2, child: _OpenedTimeRange(this)),
          ),
        ),
      );
    });
  }
}

/// Shows the opened timeline view
class _OpenedTimeRange extends StatelessWidget {
  const _OpenedTimeRange(this.state, {Key? key}) : super(key: key);
  final _ExpandingTimeRangeSelectorState state;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: context.insets.xs),
        child: SeparatedColumn(
          separatorBuilder: () => Gap(context.insets.md),
          children: [
            Text('${state.widget.startYr} - ${state.widget.endYr} AD - Chichen Itza', style: context.textStyles.h3),
            Placeholder(fallbackWidth: double.infinity, fallbackHeight: 100)
          ],
        ),
      );
}

class _ClosedTimeRange extends StatelessWidget {
  const _ClosedTimeRange(this.state, {Key? key}) : super(key: key);
  final _ExpandingTimeRangeSelectorState state;

  @override
  Widget build(BuildContext context) =>
      Text('${state.widget.startYr} - ${state.widget.endYr} AD - Chichen Itza', style: context.textStyles.titleFont);
}
