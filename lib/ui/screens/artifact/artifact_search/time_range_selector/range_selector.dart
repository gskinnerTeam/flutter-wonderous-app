import 'package:wonders/common_libs.dart';
import 'dart:math' as math;

// Expandable timerange selector component that further refines Artifact Search based on date range.
class RangeSelector extends StatefulWidget {
  const RangeSelector({
    Key? key,
    required this.start,
    required this.end,
    required this.onUpdated,
    required this.onChanged,
  }) : super(key: key);
  final double start;
  final double end;
  final void Function(double start, double end) onUpdated;
  final void Function(double start, double end) onChanged;

  @override
  State<RangeSelector> createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  double startVal = 0.0;
  double endVal = 1.0;

  double startAnchor = 0.0;
  double endAnchor = 1.0;

  double buttonWidth = 20;

  @override
  void initState() {
    super.initState();

    startVal = widget.start;
    endVal = widget.end;
  }

  void _handleStartDrag(DragStartDetails d) {
    startAnchor = startVal;
    endAnchor = endVal;
  }

  void _handleLeftDrag(DragUpdateDetails d, double width) {
    double newStart = math.max(0, math.min(endVal, startAnchor + (d.localPosition.dx) / width));
    startVal = newStart;
    setState(() {});
    widget.onUpdated(startVal, endVal);
  }

  void _handleMidDrag(DragUpdateDetails d, double width) {
    double dist = (endAnchor - startAnchor);
    double newStart = math.max(0, math.min(1 - dist, startAnchor + (d.localPosition.dx / width) - dist / 2));
    double newEnd = startVal + dist;
    startVal = newStart;
    endVal = newEnd;
    setState(() {});
    widget.onUpdated(startVal, endVal);
  }

  void _handleRightDrag(DragUpdateDetails d, double width) {
    double newEnd = math.min(1, math.max(startVal, endAnchor + (d.localPosition.dx) / width));
    endVal = newEnd;
    setState(() {});
    widget.onUpdated(startVal, endVal);
  }

  void _handleEndDrag(DragEndDetails d, double width) {
    widget.onChanged(startVal, endVal);
  }

  @override
  Widget build(BuildContext context) {
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
