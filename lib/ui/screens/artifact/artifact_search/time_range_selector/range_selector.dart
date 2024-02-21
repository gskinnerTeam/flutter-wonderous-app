import 'package:flutter/gestures.dart';
import 'package:wonders/common_libs.dart';

// Expandable timerange selector component that further refines Artifact Search based on date range.
class RangeSelector extends StatefulWidget {
  static const double handleWidth = 20;

  const RangeSelector({
    super.key,
    required this.start,
    required this.end,
    required this.min,
    required this.max,
    this.minDelta = 0,
    this.isLocked = false,
    this.onUpdated,
    this.onChanged,
  });
  final double start;
  final double end;
  final double min;
  final double max;
  final double minDelta;
  final bool isLocked;
  final void Function(double start, double end)? onUpdated;
  final void Function(double start, double end)? onChanged;

  @override
  State<RangeSelector> createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  // drag values:
  double _initStart = 0, _initEnd = 0, _initX = 0;

  // shortcuts to make calculations less fussy:
  double get _start => widget.start;
  double get _end => widget.end;
  double get _min => widget.min;
  double get _max => widget.max;
  double get _delta => widget.max - widget.min;

  void _handleStartDrag(DragDownDetails d) {
    if (widget.isLocked) return;
    _initStart = _start;
    _initEnd = _end;
    _initX = d.localPosition.dx;
  }

  void _handleLeftDrag(DragUpdateDetails d, double width) {
    if (widget.isLocked) return;
    double value = _initStart + (d.localPosition.dx - _initX) / width * _delta;
    value = max(_min, min(_end - widget.minDelta, value));
    widget.onUpdated?.call(value, _end);
  }

  void _handleMidDrag(DragUpdateDetails d, double width) {
    if (widget.isLocked) return;
    double delta = (d.localPosition.dx - _initX) / width * _delta;
    delta = max(_min - _initStart, min(_max - _initEnd, delta));
    widget.onUpdated?.call(_initStart + delta, _initEnd + delta);
  }

  void _handleRightDrag(DragUpdateDetails d, double width) {
    if (widget.isLocked) return;
    double value = _initEnd + (d.localPosition.dx - _initX) / width * _delta;
    value = max(_start + widget.minDelta, min(_max, value));
    widget.onUpdated?.call(_start, value);
  }

  void _handleEndDrag(DragEndDetails d, double width) {
    if (widget.isLocked) return;
    widget.onChanged?.call(_start, _end);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      double dragWidth = constraints.maxWidth - RangeSelector.handleWidth * 2;

      return Row(
        children: [
          Gap(dragWidth * (_start - _min) / _delta),
          _getHandle(dragWidth: dragWidth),
          Expanded(
            child: _getDragDetector(
              onUpdate: _handleMidDrag,
              dragWidth: dragWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: $styles.colors.offWhite.withOpacity(0),
                  border: Border.symmetric(
                    horizontal: BorderSide(color: $styles.colors.white.withOpacity(0.75), width: 2),
                  ),
                ),
              ),
            ),
          ),
          _getHandle(dragWidth: dragWidth, isRight: true),
          Gap(dragWidth * (1 - (_end - _min) / _delta)),
        ],
      );
    });
  }

  Widget _getHandle({required double dragWidth, bool isRight = false}) {
    return _getDragDetector(
      onUpdate: isRight ? _handleRightDrag : _handleLeftDrag,
      dragWidth: dragWidth,
      child: Transform.scale(
        scaleX: isRight ? 1 : -1,
        child: Container(
          alignment: Alignment.center,
          width: RangeSelector.handleWidth,
          decoration: BoxDecoration(
            color: $styles.colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular($styles.corners.md),
              bottomRight: Radius.circular($styles.corners.md),
            ),
          ),
          child: Icon(Icons.chevron_right, color: $styles.colors.greyStrong, size: RangeSelector.handleWidth),
        ),
      ),
    );
  }

  GestureDetector _getDragDetector({
    required Function(DragUpdateDetails, double) onUpdate,
    required double dragWidth,
    required Widget child,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragDown: _handleStartDrag,
      onHorizontalDragUpdate: (d) => onUpdate(d, dragWidth),
      onHorizontalDragEnd: (d) => _handleEndDrag(d, dragWidth),
      dragStartBehavior: DragStartBehavior.down,
      onTap: () {}, // block parent
      child: child,
    );
  }
}
