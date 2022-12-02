import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/ui/common/controls/app_loading_indicator.dart';
import 'package:wonders/ui/common/controls/eight_way_swipe_detector.dart';
import 'package:wonders/ui/common/hidden_collectible.dart';
import 'package:wonders/ui/common/modals/fullscreen_url_img_viewer.dart';
import 'package:wonders/ui/common/unsplash_photo.dart';
import 'package:wonders/ui/common/utils/app_haptics.dart';

part 'widgets/_animated_cutout_overlay.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({Key? key, this.imageSize, required this.collectionId, required this.wonderType})
      : super(key: key);
  final Size? imageSize;
  final String collectionId;
  final WonderType wonderType;

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  static const int _gridSize = 5;
  // Index starts in the middle of the grid (eg, 25 items, index will start at 13)
  int _index = ((_gridSize * _gridSize) / 2).round();
  Offset _lastSwipeDir = Offset.zero;
  final double _scale = 1;
  bool _skipNextOffsetTween = false;
  late Duration swipeDuration = $styles.times.med * .4;
  final _photoIds = ValueNotifier<List<String>>([]);
  int get _imgCount => pow(_gridSize, 2).round();

  @override
  void initState() {
    super.initState();
    _initPhotoIds();
  }

  Future<void> _initPhotoIds() async {
    var ids = unsplashLogic.getCollectionPhotos(widget.collectionId);
    if (ids != null && ids.isNotEmpty) {
      // Ensure we have enough images to fill the grid, repeat if necessary
      while (ids.length < _imgCount) {
        ids.addAll(List.from(ids));
        if (ids.length > _imgCount) ids.length = _imgCount;
      }
    }
    setState(() => _photoIds.value = ids ?? []);
  }

  void _setIndex(int value, {bool skipAnimation = false}) {
    if (value < 0 || value >= _imgCount) return;
    _skipNextOffsetTween = skipAnimation;
    setState(() => _index = value);
  }

  /// Determine the required offset to show the current selected index.
  /// index=0 is top-left, and the index=max is bottom-right.
  Offset _calculateCurrentOffset(double padding, Size size) {
    double halfCount = (_gridSize / 2).floorToDouble();
    Size paddedImageSize = Size(size.width + padding, size.height + padding);
    // Get the starting offset that would show the top-left image (index 0)
    final originOffset = Offset(halfCount * paddedImageSize.width, halfCount * paddedImageSize.height);
    // Add the offset for the row/col
    int col = _index % _gridSize;
    int row = (_index / _gridSize).floor();
    final indexedOffset = Offset(-paddedImageSize.width * col, -paddedImageSize.height * row);
    return originOffset + indexedOffset;
  }

  /// Used for hiding collectibles around the photo grid.
  int _getCollectibleIndex() {
    switch (widget.wonderType) {
      case WonderType.chichenItza:
      case WonderType.petra:
        return 0;
      case WonderType.colosseum:
      case WonderType.pyramidsGiza:
        return _gridSize - 1;
      case WonderType.christRedeemer:
      case WonderType.machuPicchu:
        return _imgCount - 1;
      case WonderType.greatWall:
      case WonderType.tajMahal:
        return _imgCount - _gridSize;
    }
  }

  /// Converts a swipe direction into a new index
  void _handleSwipe(Offset dir) {
    // Calculate new index, y swipes move by an entire row, x swipes move one index at a time
    int newIndex = _index;
    if (dir.dy != 0) newIndex += _gridSize * (dir.dy > 0 ? -1 : 1);
    if (dir.dx != 0) newIndex += (dir.dx > 0 ? -1 : 1);
    // After calculating new index, exit early if we don't like it...
    if (newIndex < 0 || newIndex > _imgCount - 1) return; // keep the index in range
    if (dir.dx < 0 && newIndex % _gridSize == 0) return; // prevent right-swipe when at right side
    if (dir.dx > 0 && newIndex % _gridSize == _gridSize - 1) return; // prevent left-swipe when at left side
    _lastSwipeDir = dir;
    AppHaptics.lightImpact();
    _setIndex(newIndex);
  }

  Future<void> _handleImageTapped(int index) async {
    if (_index == index) {
      int? newIndex = await Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) {
          final urls = _photoIds.value.map((e) {
            return UnsplashPhotoData.getSelfHostedUrl(e, UnsplashPhotoSize.med);
          }).toList();
          return FullscreenUrlImgViewer(urls: urls, index: _index);
        }),
      );
      if (newIndex != null) {
        _setIndex(newIndex, skipAnimation: true);
      }
    } else {
      _setIndex(index);
    }
  }

  bool _checkCollectibleIndex(int index) {
    return index == _getCollectibleIndex() && collectiblesLogic.isLost(widget.wonderType, 1);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
        valueListenable: _photoIds,
        builder: (_, value, __) {
          if (value.isEmpty) {
            return Center(child: AppLoadingIndicator());
          }

          Size imgSize = context.isLandscape
              ? Size(context.widthPx * .5, context.heightPx * .66)
              : Size(context.widthPx * .66, context.heightPx * .5);
          imgSize = (widget.imageSize ?? imgSize) * _scale;
          // Get transform offset for the current _index
          final padding = $styles.insets.md;

          var gridOffset = _calculateCurrentOffset(padding, imgSize);
          gridOffset += Offset(0, -context.mq.padding.top / 2);
          final offsetTweenDuration = _skipNextOffsetTween ? Duration.zero : swipeDuration;
          final cutoutTweenDuration = _skipNextOffsetTween ? Duration.zero : swipeDuration * .5;
          return  _AnimatedCutoutOverlay(
            animationKey: ValueKey(_index),
            cutoutSize: imgSize,
            swipeDir: _lastSwipeDir,
            duration: cutoutTweenDuration,
            opacity: _scale == 1 ? .7 : .5,
            child: SafeArea(
              bottom: false,
              // Place content in overflow box, to allow it to flow outside the parent
              child: OverflowBox(
                maxWidth: _gridSize * imgSize.width + padding * (_gridSize - 1),
                maxHeight: _gridSize * imgSize.height + padding * (_gridSize - 1),
                alignment: Alignment.center,
                // Detect swipes in order to change index
                child: EightWaySwipeDetector(
                  onSwipe: _handleSwipe,
                  threshold: 30,
                  // A tween animation builder moves from image to image based on current offset
                  child: TweenAnimationBuilder<Offset>(
                    tween: Tween(begin: gridOffset, end: gridOffset),
                    duration: offsetTweenDuration,
                    curve: Curves.easeOut,
                    builder: (_, value, child) => Transform.translate(offset: value, child: child),
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: _gridSize,
                      childAspectRatio: imgSize.aspectRatio,
                      mainAxisSpacing: padding,
                      crossAxisSpacing: padding,
                      children: List.generate(_imgCount, (i) => _buildImage(i, swipeDuration, imgSize)),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildImage(int index, Duration swipeDuration, Size imgSize) {
    /// Bind to collectibles.statesById because we might need to rebuild if a collectible is found.
    return ValueListenableBuilder(
        valueListenable: collectiblesLogic.statesById,
        builder: (_, __, ___) {
          bool selected = index == _index;
          final imgUrl = _photoIds.value[index];

          late String semanticLbl;
          if (_checkCollectibleIndex(index)) {
            semanticLbl = $strings.collectibleItemSemanticCollectible;
          } else {
            semanticLbl = !selected
                ? $strings.photoGallerySemanticFocus(index + 1, _imgCount)
                : $strings.photoGallerySemanticFullscreen(index + 1, _imgCount);
          }
          return MergeSemantics(
            child: Semantics(
              focused: selected,
              image: !_checkCollectibleIndex(index),
              liveRegion: selected,
              onIncrease: () => _handleImageTapped(_index + 1),
              onDecrease: () => _handleImageTapped(_index - 1),
              child: AppBtn.basic(
                semanticLabel: semanticLbl,
                onPressed: () {
                  if (_checkCollectibleIndex(index) && selected) return;
                  _handleImageTapped(index);
                },
                child: _checkCollectibleIndex(index)
                    ? HiddenCollectible(widget.wonderType, index: 1, size: 100)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: imgSize.width,
                          height: imgSize.height,
                          child: TweenAnimationBuilder<double>(
                            duration: $styles.times.med,
                            curve: Curves.easeOut,
                            tween: Tween(begin: 1, end: selected ? 1.15 : 1),
                            builder: (_, value, child) => Transform.scale(scale: value, child: child),
                            child: UnsplashPhoto(
                              imgUrl,
                              fit: BoxFit.cover,
                              size: UnsplashPhotoSize.med,
                            ).animate().fade(),
                          ),
                        ),
                      ),
              ),
            ),
          );
        });
  }
}
