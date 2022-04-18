import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/ui/common/animated_motion_blur.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/common/controls/eight_way_swipe_detector.dart';
import 'package:wonders/ui/common/unsplash_photo.dart';
import 'package:wonders/ui/common/utils/page_routes.dart';
import 'package:wonders/ui/screens/image_gallery/animated_cutout_overlay.dart';
import 'package:wonders/ui/screens/image_gallery/fullscreen_unsplash_photo_viewer.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({Key? key, this.imageSize, required this.collectionId}) : super(key: key);
  final Size? imageSize;
  final String collectionId;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  static const int _gridCount = 5;
  // Index starts in the middle of the grid (eg, 25 items, index will start at 13)
  int _index = ((_gridCount * _gridCount) / 2).round();
  late int _prevIndex = _index;
  Offset _lastSwipeDir = Offset.zero;
  double _scale = 1;
  bool _skipNextOffsetTween = false;
  late Duration swipeDuration = context.times.med * .6;

  final _photoIds = ValueNotifier<List<String>>([]);
  int get _imgCount => pow(_gridCount, 2).round();

  @override
  void initState() {
    super.initState();
    _loadCollections();
  }

  void _loadCollections() async {
    var ids = (await unsplashLogic.getCollectionPhotos(widget.collectionId));
    if (!mounted) return;
    if (ids != null && ids.isNotEmpty) {
      // Ensure we have enough images to fill the grid, repeat if necessary
      while (ids.length < _imgCount) {
        ids.addAll(List.from(ids));
        if (ids.length > _imgCount) ids.length = _imgCount;
      }
      // Preload the initial image
      await unsplashLogic.preload(context, ids[_index], size: UnsplashPhotoSize.med);
      // Start loading the other 8 visible images, but don't await them, just give them a head-start.
      final indexes = [_index + 1, _index - 1, _index - _gridCount, _index + _gridCount];
      for (var i in indexes) {
        unsplashLogic.preload(context, ids[i], size: UnsplashPhotoSize.med);
      }
      await Future.delayed(1.seconds);
      _photoIds.value = ids;
    }
  }

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
        PageRoutes.fadeScale(FullScreenUnsplashPhotoViewer(_photoIds.value[index], _photoIds.value)),
      );
      if (newId != null) {
        _setIndex(_photoIds.value.indexOf(newId));
      }
    } else {
      _setIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
        valueListenable: _photoIds,
        builder: (_, value, __) {
          if (value.isEmpty) {
            return Center(child: AppLoader());
          }

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
                child: SafeArea(
                  /// Place content in overflow box, to allow it to flow outside the parent
                  child: OverflowBox(
                    maxWidth: _gridCount * imgSize.width + padding * (_gridCount - 1),
                    maxHeight: _gridCount * imgSize.height + padding * (_gridCount - 1),
                    alignment: Alignment.center,
                    // Detect swipes in order to change index
                    child: EightWaySwipeDetector(
                      onSwipe: _handleSwipe,
                      threshold: 10 + 100 * settingsLogic.swipeThreshold.value,
                      // A tween animation builder moves from image to image based on current offset
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
                          crossAxisCount: _gridCount,
                          childAspectRatio: imgSize.aspectRatio,
                          mainAxisSpacing: padding,
                          crossAxisSpacing: padding,
                          children: List.generate(_imgCount, (i) => _buildImage(i, swipeDuration, imgSize)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: BottomCenter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: context.insets.offset),
                    child: CircleIconBtn(
                      icon: _scale == 1 ? Icons.zoom_out : Icons.zoom_in,
                      onPressed: _handleZoomToggled,
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  Widget _buildImage(int index, Duration swipeDuration, Size imgSize) {
    bool selected = index == _index;
    bool wasSelected = index == _prevIndex;
    return GestureDetector(
      onTap: () => _handleImageTapped(index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: AnimatedMotionBlur(
          swipeDuration,
          animationKey: ValueKey(_index),
          blurStrength: 15,
          enabled: settingsLogic.enableMotionBlur.value && (selected || wasSelected),
          dir: _lastSwipeDir,
          child: SizedBox(
            width: imgSize.width,
            height: imgSize.height,
            child: TweenAnimationBuilder<double>(
              duration: context.times.med,
              curve: Curves.easeOut,
              tween: Tween(begin: 1, end: selected ? 1.15 : 1),
              builder: (_, value, child) => Transform.scale(child: child, scale: value),
              child: UnsplashPhoto(
                _photoIds.value[index],
                fit: BoxFit.cover,
                size: UnsplashPhotoSize.med,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
