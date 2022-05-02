import 'package:wonders/common_libs.dart';

// Expandable timerange selector component that further refines Artifact Search based on date range.
class RangeSelector extends StatefulWidget {
  const RangeSelector({
    Key? key,
    required this.start,
    required this.end,
    required this.isLocked,
    required this.onUpdated,
    required this.onChanged,
  }) : super(key: key);
  final double start;
  final double end;
  final bool isLocked;
  final void Function(double start, double end) onUpdated;
  final void Function(double start, double end) onChanged;

  @override
  State<RangeSelector> createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  final _buttonWidth = 20.0;

  double _startVal = 0.0;
  double _endVal = 1.0;

  double _startAnchor = 0.0;
  double _endAnchor = 1.0;

  @override
  void initState() {
    super.initState();

    _startVal = widget.start;
    _endVal = widget.end;
  }

  void _handleStartDrag(DragStartDetails d) {
    HapticFeedback.mediumImpact();
    if (widget.isLocked) return;
    _startAnchor = _startVal;
    _endAnchor = _endVal;
  }

  void _handleLeftDrag(DragUpdateDetails d, double width) {
    if (widget.isLocked) return;
    double newStart = max(0, min(_endVal, _startAnchor + (d.localPosition.dx) / width));
    _startVal = newStart;
    setState(() {});
    widget.onUpdated(_startVal, _endVal);
  }

  void _handleMidDrag(DragUpdateDetails d, double width) {
    if (widget.isLocked) return;
    double dist = (_endAnchor - _startAnchor);
    double newStart = max(0, min(1 - dist, _startAnchor + (d.localPosition.dx / width) - dist / 2));
    double newEnd = _startVal + dist;
    _startVal = newStart;
    _endVal = newEnd;
    setState(() {});
    widget.onUpdated(_startVal, _endVal);
  }

  void _handleRightDrag(DragUpdateDetails d, double width) {
    if (widget.isLocked) return;
    double newEnd = min(1, max(_startVal, _endAnchor + (d.localPosition.dx) / width));
    _endVal = newEnd;
    setState(() {});
    widget.onUpdated(_startVal, _endVal);
  }

  void _handleEndDrag(DragEndDetails d, double width) {
    if (widget.isLocked) return;
    widget.onChanged(_startVal, _endVal);
  }

  @override
  Widget build(BuildContext context) {
    var buttonColor = widget.isLocked ? context.colors.greyMedium : context.colors.greyStrong;

    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        width: constraints.maxWidth - _buttonWidth * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(context.corners.md)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Left-side Padding
            Gap((constraints.maxWidth - _buttonWidth * 2) * _startVal),

            // Left-side button
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: _handleStartDrag,
              onHorizontalDragUpdate: (d) => _handleLeftDrag(d, constraints.maxWidth),
              onHorizontalDragEnd: (d) => _handleEndDrag(d, constraints.maxWidth),
              child: Container(
                alignment: Alignment.centerLeft,
                width: _buttonWidth,
                decoration: BoxDecoration(
                  color: buttonColor,
                  border: Border.all(color: buttonColor, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.corners.md),
                    bottomLeft: Radius.circular(context.corners.md),
                  ),
                ),
                child: Center(child: Icon(Icons.chevron_left, color: context.colors.offWhite, size: _buttonWidth - 2)),
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
                      color: context.colors.offWhite.withOpacity(0.2),
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
                width: _buttonWidth,
                decoration: BoxDecoration(
                  color: buttonColor,
                  border: Border.all(color: buttonColor, width: 1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(context.corners.md),
                    bottomRight: Radius.circular(context.corners.md),
                  ),
                ),
                child: Center(child: Icon(Icons.chevron_right, color: context.colors.offWhite, size: _buttonWidth - 2)),
              ),
            ),

            // Right-side Padding
            Gap((constraints.maxWidth - _buttonWidth * 2) * (1 - _endVal)),
          ],
        ),
      );
    });
  }
}
