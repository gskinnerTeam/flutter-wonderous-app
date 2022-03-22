import 'package:flutter/scheduler.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/eight_way_swipe_detector.dart';
import 'package:wonders/ui/common/motion_blur.dart';
import 'package:wonders/ui/common/swipeable_image_grid/animated_cutout_overlay.dart';
import 'package:wonders/ui/common/swipeable_image_grid/opening_grid_image.dart';

class SwipeableImageGrid extends StatefulWidget {
  SwipeableImageGrid({Key? key, this.gridCount = 5, this.imageSize}) : super(key: key) {
    assert(gridCount % 2 == 1 && gridCount > 2, 'Grid count must be an odd number equal to 3 or more');
  }
  final Size? imageSize;
  final int gridCount;

  @override
  State<SwipeableImageGrid> createState() => _SwipeableImageGridState();
}

class _SwipeableImageGridState extends State<SwipeableImageGrid> {
  late int _index = ((widget.gridCount * widget.gridCount) / 2).round();
  late int _prevIndex = _index;
  Offset _lastSwipeDir = Offset.zero;

  int get _gridCount => widget.gridCount;
  int get _imgCount => pow(_gridCount, 2).round();

  Size get _imgSize => (widget.imageSize ?? Size(context.widthPct(.65), context.heightPct(.55))) * _scale;
  double _scale = 1;

  void _setIndex(int value) {
    _prevIndex = _index;
    setState(() => _index = value);
  }

  /// Converts a swipe direction into a new index
  void _handleSwipe(Offset dir) {
    // Calculate new index, y swipes move by an entire row, x swipes move one index at a time
    int newIndex = _index;
    if (dir.dy != 0) newIndex += _gridCount * (dir.dy > 0 ? -1 : 1);
    if (dir.dx != 0) newIndex += (dir.dx > 0 ? -1 : 1);
    // After calculating new index, exit early if we don't like it...
    if (newIndex < 0 || newIndex > _imgCount - 1) return; // keep the index in range
    if (dir.dx < 0 && newIndex % _gridCount == 0) return; // prevent right-swipe when at right side
    if (dir.dx > 0 && newIndex % _gridCount == _gridCount - 1) return; // prevent left-swipe when at left side
    _lastSwipeDir = dir;
    _setIndex(newIndex);
  }

  /// Determine the required offset to show the current selected index.
  /// index=0 is top-left, and the index=max is bottom-right.
  Offset _calculateCurrentOffset(double padding) {
    double halfCount = (_gridCount / 2).floorToDouble();
    Size paddedImageSize = Size(_imgSize.width + padding, _imgSize.height + padding);
    // Get the starting offset that would show the top-left image (index 0)
    final originOffset = Offset(halfCount * paddedImageSize.width, halfCount * paddedImageSize.height);
    // Add the offset for the row/col
    int col = _index % _gridCount;
    int row = (_index / _gridCount).floor();
    final indexedOffset = Offset(-paddedImageSize.width * col, -paddedImageSize.height * row);
    return originOffset + indexedOffset;
  }

  void _handleImageTapped(int index) => _setIndex(index);

  @override
  Widget build(BuildContext context) {
    // Get transform offset for the current _index
    final padding = context.insets.lg;
    final gridOffset = _calculateCurrentOffset(padding);
    timeDilation = 1;

    // Layout
    final swipeDuration = context.times.med * .55;
    // A overlay with a transparent middle sits on top of everything, animating itself each time index changes
    return Stack(
      children: [
        AnimatedCutoutOverlay(
          cutoutSize: _imgSize,
          swipeDir: _lastSwipeDir,
          animationKey: ValueKey(_index),
          duration: swipeDuration * .5,
          // Clip the overflow box to prevent rendering outside of the viewport
          // TODO: Check whether clipping the OverflowBox is actually a perf win?
          child: ClipRect(
            child: OverflowBox(
              maxWidth: _gridCount * _imgSize.width + padding * (_gridCount - 1),
              maxHeight: _gridCount * _imgSize.height + padding * (_gridCount - 1),
              alignment: Alignment.center,
              // Detect swipes in order to change index
              child: EightWaySwipeDetector(
                onSwipe: _handleSwipe,
                // Move the entire grid so that the selected index is centered on screen
                child: GTweener(
                  [GMove(from: gridOffset, to: gridOffset)],
                  duration: swipeDuration,
                  curve: Curves.easeOut,
                  // Use a wrap to display the images
                  child: GridView.count(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: _gridCount,
                      childAspectRatio: _imgSize.width / _imgSize.height,
                      crossAxisSpacing: padding,
                      mainAxisSpacing: padding,
                      children: List.generate(
                        _imgCount,
                        (index) {
                          bool selected = index == _index;
                          bool wasSelected = index == _prevIndex;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            // Wrap a motion blur around the selected and previous items
                            child: MotionBlur(
                              swipeDuration,
                              // use a key to force motion blurs to re-run when index changes
                              animationKey: ValueKey(_index),
                              enabled: selected || wasSelected,
                              dir: _lastSwipeDir,
                              // Make each img tappable, so user can easily jump between them
                              child: GestureDetector(
                                onTap: selected ? null : () => _handleImageTapped(index),
                                child: OpeningGridImage(_imgSize, selected: selected),
                              ),
                            ),
                          );
                        },
                      )
                      // Wrap(
                      //   spacing: padding,
                      //   runSpacing: padding,
                      //   children: List.generate(_imgCount, (index) {
                      //     bool selected = index == _index;
                      //     bool wasSelected = index == _prevIndex;
                      //     return ClipRRect(
                      //       borderRadius: BorderRadius.circular(6),
                      //       // Wrap a motion blur around the selected and previous items
                      //       child: MotionBlur(
                      //         swipeDuration,
                      //         // use a key to force motion blurs to re-run when index changes
                      //         animationKey: ValueKey(_index),
                      //         enabled: selected || wasSelected,
                      //         dir: _lastSwipeDir,
                      //         // Make each img tappable, so user can easily jump between them
                      //         child: GestureDetector(
                      //           onTap: selected ? null : () => _handleImageTapped(index),
                      //           child: OpeningGridImage(_imgSize, selected: selected),
                      //         ),
                      //       ),
                      //     );
                      //   }),
                      // ),
                      ),
                ),
              ),
            ),
          ),
        ),
        Center(
            child: SizedBox(height: 100, child: Slider(value: _scale, onChanged: (v) => setState(() => _scale = v)))),
      ],
    );
  }
}
