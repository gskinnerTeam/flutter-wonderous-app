import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';
import 'dart:math' as math;

// Expandable timerange selector component that further refines Artifact Search based on date range.
class TimelineVisual extends StatelessWidget {
  const TimelineVisual({Key? key, required this.wonderDataList}) : super(key: key);

  final List<WonderData> wonderDataList;

  @override
  Widget build(BuildContext context) {
    int earliestYr = wonderDataList[0].startYr;
    int latestYr = wonderDataList[0].endYr;

    for (WonderData data in wonderDataList) {
      if (data.startYr < earliestYr) {
        earliestYr = data.startYr;
      }
      if (data.endYr < latestYr) {
        latestYr = data.endYr;
      }
    }

    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        width: constraints.maxWidth - buttonWidth * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(context.corners.md)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Left-side Padding
            Gap((constraints.maxWidth - buttonWidth * 2) * startVal),

            // Left-side button
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: _handleStartDrag,
              onHorizontalDragUpdate: (d) => _handleLeftDrag(d, constraints.maxWidth),
              onHorizontalDragEnd: (d) => _handleEndDrag(d, constraints.maxWidth),
              child: Container(
                alignment: Alignment.centerLeft,
                width: buttonWidth,
                decoration: BoxDecoration(
                  color: context.colors.greyStrong,
                  border: Border.all(color: context.colors.greyStrong, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.corners.md),
                    bottomLeft: Radius.circular(context.corners.md),
                  ),
                ),
                child: Center(child: Icon(Icons.chevron_left, color: context.colors.bg, size: buttonWidth - 2)),
              ),
            ),

            // Glass pane
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragStart: _handleStartDrag,
                onHorizontalDragUpdate: (d) => _handleMidDrag(d, constraints.maxWidth),
                onHorizontalDragEnd: (d) => _handleEndDrag(d, constraints.maxWidth),
                child: Container(
                  decoration: BoxDecoration(
                      color: context.colors.bg.withOpacity(0.2),
                      backgroundBlendMode: BlendMode.screen,
                      border: Border.symmetric(horizontal: BorderSide(color: context.colors.greyStrong, width: 1))),
                ),
              ),
            ),

            // Right-side button
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: _handleStartDrag,
              onHorizontalDragUpdate: (d) => _handleRightDrag(d, constraints.maxWidth),
              onHorizontalDragEnd: (d) => _handleEndDrag(d, constraints.maxWidth),
              child: Container(
                alignment: Alignment.centerRight,
                width: buttonWidth,
                decoration: BoxDecoration(
                  color: context.colors.greyStrong,
                  border: Border.all(color: context.colors.greyStrong, width: 1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(context.corners.md),
                    bottomRight: Radius.circular(context.corners.md),
                  ),
                ),
                child: Center(child: Icon(Icons.chevron_right, color: context.colors.bg, size: buttonWidth - 2)),
              ),
            ),

            // Right-side Padding
            Gap((constraints.maxWidth - buttonWidth * 2) * (1 - endVal)),
          ],
        ),
      );
    });
  }
}
