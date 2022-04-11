import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';
import 'dart:math' as math;

// Expandable timerange selector component that further refines Artifact Search based on date range.
class RangeSelector extends StatefulWidget {
  const RangeSelector({
    Key? key,
    required this.start,
    required this.end,
    required this.onChanged,
  }) : super(key: key);
  final double start;
  final double end;
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
    double newStart = math.max(0,
        math.min(endVal - (buttonWidth * 2 / width), startAnchor + (d.localPosition.dx - (buttonWidth / 2)) / width));
    setState(() {
      startVal = newStart;
    });
  }

  void _handleMidDrag(DragUpdateDetails d, double width) {
    double dist = (endAnchor - startAnchor);
    double newStart = math.max(0, math.min(1 - dist, startAnchor + (d.localPosition.dx / width) - dist / 2));
    double newEnd = startVal + dist;
    setState(() {
      startVal = newStart;
      endVal = newEnd;
    });
  }

  void _handleRightDrag(DragUpdateDetails d, double width) {
    double newEnd = math.min(1,
        math.max(startVal + (buttonWidth * 2 / width), endAnchor + (d.localPosition.dx - (buttonWidth / 2)) / width));
    setState(() {
      endVal = newEnd;
    });
  }

  void _handleEndDrag(DragEndDetails d, double width) {
    // This looks a bit odd, but bear with me. Buttons are buttonWidth wide, and because they press against
    // each other, the closest they'll get is buttonWidth px apart. We want that case to say that startVal and
    // endVal are the same. So to do that, we'll take this width fraction and multiply it by how far the startVal and
    // endVal are away from 0 and 1 respectively. This way, it'll press that offset in alightly and we'll end up
    // getting the same values on either side if they are buttonWidth px apart.
    //double widthFrac = buttonWidth * 2 / (width - buttonWidth * 2);
    //widget.onChanged(startVal + (startVal * widthFrac), endVal - ((1 - endVal) * widthFrac));
    widget.onChanged(startVal, endVal);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(context.corners.md)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Left-side Padding
            Gap(constraints.maxWidth * startVal),

            // Left-side button
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: _handleStartDrag,
              onHorizontalDragUpdate: (d) => _handleLeftDrag(d, constraints.maxWidth),
              onHorizontalDragEnd: (d) => _handleEndDrag(d, constraints.maxWidth),
              child: Container(
                alignment: Alignment.centerRight,
                width: buttonWidth,
                decoration: BoxDecoration(
                  color: context.colors.greyStrong,
                  border: Border.all(color: context.colors.greyStrong, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.corners.md),
                    bottomLeft: Radius.circular(context.corners.md),
                  ),
                ),
                child: Icon(Icons.arrow_left, color: context.colors.bg),
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
                alignment: Alignment.centerLeft,
                width: buttonWidth,
                decoration: BoxDecoration(
                  color: context.colors.greyStrong,
                  border: Border.all(color: context.colors.greyStrong, width: 1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(context.corners.md),
                    bottomRight: Radius.circular(context.corners.md),
                  ),
                ),
                child: Icon(Icons.arrow_right, color: context.colors.bg),
              ),
            ),

            // Right-side Padding
            Gap(constraints.maxWidth * (1 - endVal)),
          ],
        ),
      );
    });
  }
}
