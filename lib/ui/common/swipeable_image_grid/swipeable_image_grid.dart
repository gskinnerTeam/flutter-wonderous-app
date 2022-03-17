import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/eight_way_swipe_detector.dart';
import 'package:wonders/ui/common/motion_blur.dart';
import 'package:wonders/ui/common/swipeable_image_grid/animated_cutout_overlay.dart';
import 'package:wonders/ui/common/swipeable_image_grid/opening_image.dart';

class SwipeableImageGrid extends StatefulWidget {
  SwipeableImageGrid({Key? key, this.gridCount = 5, this.imageSize = const Size(300, 450)}) : super(key: key) {
    assert(gridCount % 2 == 1 && gridCount > 2, 'Grid count must be an odd number equal to 3 or more');
  }
  final Size imageSize;
  final int gridCount;

  @override
  State<SwipeableImageGrid> createState() => _SwipeableImageGridState();
}

class _SwipeableImageGridState extends State<SwipeableImageGrid> {
  late int _index = ((widget.gridCount * widget.gridCount) / 2).round();
  int get gridCount => widget.gridCount;
  int get halfGridCount => (widget.gridCount / 2).floor();
  double get imgW => widget.imageSize.width;
  double get imgH => widget.imageSize.height;
  int get imgCount => pow(gridCount, 2).round();
  MotionBlurController? _blurController;
  Offset _lastSwipeDir = Offset.zero;

  void setIndex(int value) {
    _blurController?.restart();
    setState(() => _index = value);
  }

  /// Converts a swipe direction into a new index
  void _handleSwipe(Offset dir) {
    // Calculate new index, y swipes move by an entire row, x swipes move one index at a time
    int newIndex = _index;
    if (dir.dy != 0) newIndex += gridCount * (dir.dy > 0 ? -1 : 1);
    if (dir.dx != 0) newIndex += (dir.dx > 0 ? -1 : 1);
    // After calculating new index, exit early if we don't like it...
    if (newIndex < 0 || newIndex > imgCount - 1) return; // keep the index in range
    if (dir.dx < 0 && newIndex % gridCount == 0) return; // prevent right-swipe when at right side
    if (dir.dx > 0 && newIndex % gridCount == gridCount - 1) return; // prevent left-swipe when at left side
    _lastSwipeDir = dir;
    setIndex(newIndex);
  }

  /// Determine the required offset to show the current selected index.
  /// index=0 is top-left, and the index=max is bottom-right.
  Offset _calculateCurrentOffset(double padding) {
    double halfCount = (gridCount / 2).floorToDouble();
    Size paddedImageSize = Size(imgW + padding, imgH + padding);
    // Get the starting offset that would show the top-left image (index 0)
    final originOffset = Offset(halfCount * paddedImageSize.width, halfCount * paddedImageSize.height);
    // Add the offset for the row/col
    int col = _index % gridCount;
    int row = (_index / gridCount).floor();
    final indexedOffset = Offset(-paddedImageSize.width * col, -paddedImageSize.height * row);
    return originOffset + indexedOffset;
  }

  @override
  Widget build(BuildContext context) {
    // Get transform offset for the current _index
    final padding = context.insets.lg;
    final gridOffset = _calculateCurrentOffset(padding);

    /// Layout
    // A cutout sits on top of everything, animating itself each time index changes
    return AnimatedCutoutOverlay(
      cutoutSize: widget.imageSize,
      animationKey: ValueKey(_index),
      duration: context.times.fast,
      // A motion blur, runs each time index is changed
      child: MotionBlur(
        context.times.med * .4,
        onInit: (c) => _blurController = c,
        dir: _lastSwipeDir,
        // Use an overflow box, so the grid of images can be any size it wants
        child: OverflowBox(
          maxWidth: gridCount * imgW + padding * (gridCount - 1),
          maxHeight: gridCount * imgH + padding * (gridCount - 1),
          alignment: Alignment.center,
          // Detect swipes in order to change index
          child: EightWaySwipeDetector(
            onSwipe: _handleSwipe,
            child: TweenAnimationBuilder<Offset>(
              tween: Tween(begin: gridOffset, end: gridOffset),
              duration: context.times.med,
              curve: Curves.easeOutBack,
              // Move the entire grid so that the selected image is centered on screen
              builder: (_, value, child) => Transform.translate(offset: value, child: child),
              // Use a wrap to display the images
              child: Wrap(
                spacing: padding,
                runSpacing: padding,
                children: List.generate(
                  imgCount,
                  (index) => GestureDetector(
                    // Index can also be changed by tapping
                    onTap: index == _index ? null : () => setIndex(index),
                    child: OpeningImage(widget.imageSize, selected: index == _index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
