import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/circle_button.dart';
import 'package:wonders/ui/common/controls/eight_way_swipe_detector.dart';
import 'package:wonders/ui/common/animated_motion_blur.dart';
import 'package:wonders/ui/common/page_routes.dart';
import 'package:wonders/ui/common/unsplash_photo.dart';
import 'package:wonders/ui/screens/image_gallery/animated_cutout_overlay.dart';
import 'package:wonders/ui/screens/image_gallery/fullscreen_photo_viewer.dart';

class ImageGallery extends StatefulWidget {
  ImageGallery({Key? key, this.gridCount = 5, this.imageSize, required this.photoIds}) : super(key: key) {
    assert(gridCount % 2 == 1 && gridCount > 2, 'Grid count must be an odd number equal to 3 or more');
    assert(gridCount * gridCount <= photoIds.length, 'Images should be a list with length equal to gridCount^2');
  }
  final Size? imageSize;
  final int gridCount;
  final List<String> photoIds;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late int _index = ((widget.gridCount * widget.gridCount) / 2).round();
  late int _prevIndex = _index;
  Offset _lastSwipeDir = Offset.zero;

  int get _gridCount => widget.gridCount;
  int get _imgCount => pow(_gridCount, 2).round();

  double _scale = 1;
  bool _skipNextOffsetTween = false;
  void _handleZoomToggled() => setState(() {
        _skipNextOffsetTween = true;
        _scale = _scale == 1 ? .65 : 1;
      });

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
  Offset _calculateCurrentOffset(double padding, Size size) {
    double halfCount = (_gridCount / 2).floorToDouble();
    Size paddedImageSize = Size(size.width + padding, size.height + padding);
    // Get the starting offset that would show the top-left image (index 0)
    final originOffset = Offset(halfCount * paddedImageSize.width, halfCount * paddedImageSize.height);
    // Add the offset for the row/col
    int col = _index % _gridCount;
    int row = (_index / _gridCount).floor();
    final indexedOffset = Offset(-paddedImageSize.width * col, -paddedImageSize.height * row);
    return originOffset + indexedOffset;
  }

  void _handleImageTapped(int index) async {
    if (_index == index) {
      String? newId = await Navigator.push(
        context,
        PageRoutes.fadeScale(FullScreenUnsplashPhotoViewer(widget.photoIds[index], widget.photoIds)),
      );
      if (newId != null) {
        _setIndex(widget.photoIds.indexOf(newId));
      }
    } else {
      _setIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    Duration swipeDuration = context.times.med * .55;
    Size imgSize = (widget.imageSize ?? Size(context.widthPx * .7, context.heightPx * .6)) * _scale;
    // Get transform offset for the current _index
    final padding = context.insets.sm;
    var gridOffset = _calculateCurrentOffset(padding, imgSize);
    // For some reason we need to add in half of the top-padding when this view does not use a safeArea.
    // TODO: Try and figure out why we need to incorporate top padding here, it's counter-intuitive. Maybe GridView or another of the material components is doing something we don't want?
    gridOffset += Offset(0, -context.mq.padding.top / 2);
    final offsetTweenDuration = _skipNextOffsetTween ? Duration.zero : swipeDuration;
    _skipNextOffsetTween = false;

    // Layout
    return Stack(
      children: [
        // A overlay with a transparent middle sits on top of everything, animating itself each time index changes
        AnimatedCutoutOverlay(
          animationKey: ValueKey(_index),
          cutoutSize: imgSize,
          swipeDir: _lastSwipeDir,
          duration: swipeDuration * .5,
          opacity: _scale == 1 ? .7 : .5,
          // TODO: Check whether clipping the OverflowBox is actually a perf win?
          // Clip the overflow box to prevent rendering outside of the viewport
          child: SafeArea(
            child: OverflowBox(
              maxWidth: _gridCount * imgSize.width + padding * (_gridCount - 1),
              maxHeight: _gridCount * imgSize.height + padding * (_gridCount - 1),
              alignment: Alignment.center,
              // Detect swipes in order to change index
              child: EightWaySwipeDetector(
                onSwipe: _handleSwipe,
                threshold: 10 + 100 * settingsLogic.swipeThreshold.value,
                child: TweenAnimationBuilder<Offset>(
                  tween: Tween(begin: gridOffset, end: gridOffset),
                  duration: offsetTweenDuration,
                  curve: Curves.easeOut,
                  builder: (_, value, child) => Transform.translate(
                    offset: value,
                    child: child,
                  ),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: widget.gridCount,
                    childAspectRatio: imgSize.aspectRatio,
                    mainAxisSpacing: padding,
                    crossAxisSpacing: padding,
                    children: List.generate(_imgCount, (index) {
                      bool selected = index == _index;
                      bool wasSelected = index == _prevIndex;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        // Wrap a motion blur around the selected and previous items
                        child: AnimatedMotionBlur(
                          swipeDuration,
                          // use a key to force motion blurs to re-run when index changes
                          animationKey: ValueKey(_index),
                          blurStrength: 15,
                          enabled: settingsLogic.enableMotionBlur.value && (selected || wasSelected),
                          dir: _lastSwipeDir,
                          // Make each img tappable, so user can easily jump between them
                          child: GestureDetector(
                            onTap: () => _handleImageTapped(index),
                            child: SizedBox(
                              width: imgSize.width,
                              height: imgSize.height,
                              child: TweenAnimationBuilder<double>(
                                duration: context.times.med,
                                curve: Curves.easeOut,
                                tween: Tween(begin: 1, end: selected ? 1.15 : 1),
                                builder: (_, value, child) => Transform.scale(child: child, scale: value),
                                child: UnsplashPhoto(widget.photoIds[index], fit: BoxFit.cover, targetSize: 600),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: BottomCenter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: CircleButton(
                  child: Icon(_scale == 1 ? Icons.zoom_out : Icons.zoom_in), onPressed: _handleZoomToggled),
            ),
          ),
        )
      ],
    );
  }
}
