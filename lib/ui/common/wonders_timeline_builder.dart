import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

/// Visualizes all of the wonders over time.
/// Distributes the wonders over multiple "tracks" so that they do not overlap.
/// Provides a builder, so the visual representation of each track entry can be customized
class WondersTimelineBuilder extends StatelessWidget {
  const WondersTimelineBuilder({
    super.key,
    this.selectedWonders = const [],
    this.timelineBuilder,
    this.axis = Axis.horizontal,
    this.crossAxisGap,
    this.minSize = 10,
  });
  final List<WonderType> selectedWonders;
  final Widget Function(BuildContext, WonderData type, bool isSelected)? timelineBuilder;
  final Axis axis;
  final double? crossAxisGap;
  final double minSize;
  bool get isHz => axis == Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    final gap = crossAxisGap ?? $styles.insets.xs;
    // Depending on axis, we put all the wonders in a hz row, or vt column
    Widget wrapFlex(List<Widget> c) {
      c = c.map<Widget>((w) => Expanded(child: w)).toList();
      return isHz
          ? SeparatedColumn(verticalDirection: VerticalDirection.up, separatorBuilder: () => Gap(gap), children: c)
          : SeparatedRow(separatorBuilder: () => Gap(gap), children: c);
    }

    return LayoutBuilder(builder: (_, constraints) {
      /// Builds one timeline track, may contain multiple wonders, but they should not overlap
      Widget buildSingleTimelineTrack(BuildContext context, List<WonderType> types) {
        return Stack(
          clipBehavior: Clip.none,
          children: types.map(
            (t) {
              final data = wondersLogic.getData(t);
              // To keep the math simple, first figure out a multiplier we can use to convert yrs to pixels.
              int totalYrs = wondersLogic.timelineEndYear - wondersLogic.timelineStartYear;
              double pxToYrRatio = totalYrs / ((isHz ? constraints.maxWidth : constraints.maxHeight));
              // Now we just need to calculate year spans, and then convert them to pixels for the start/end position in the Stack
              int wonderYrs = data.endYr - data.startYr;
              int yrsFromStart = data.startYr - wondersLogic.timelineStartYear;
              double startPx = yrsFromStart / pxToYrRatio;
              double sizePx = wonderYrs / pxToYrRatio;
              if (sizePx < minSize) {
                double yearDelta = ((minSize - sizePx) / 2);
                sizePx = minSize;
                startPx -= yearDelta;
              }
              final isSelected = selectedWonders.contains(data.type);
              final child =
                  timelineBuilder?.call(context, data, isSelected) ?? _DefaultTrackEntry(isSelected: isSelected);
              return isHz
                  ? Positioned(left: startPx, width: sizePx, top: 0, bottom: 0, child: child)
                  : Positioned(top: startPx, height: sizePx, left: 0, right: 0, child: child);
            },
          ).toList(),
        );
      }

      return wrapFlex([
        // Track 1
        buildSingleTimelineTrack(
          context,
          [
            WonderType.greatWall,
            WonderType.pyramidsGiza,
            WonderType.christRedeemer,
          ],
        ),
        // Track 2
        buildSingleTimelineTrack(
          context,
          [
            WonderType.petra,
            WonderType.machuPicchu,
          ],
        ),
        // Track 3
        buildSingleTimelineTrack(
          context,
          [
            WonderType.chichenItza,
            WonderType.tajMahal,
            WonderType.colosseum,
          ],
        ),
      ]);
    });
  }
}

class _DefaultTrackEntry extends StatelessWidget {
  const _DefaultTrackEntry({required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? $styles.colors.accent2 : Colors.transparent,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: $styles.colors.accent2),
      ),
    );
  }
}
