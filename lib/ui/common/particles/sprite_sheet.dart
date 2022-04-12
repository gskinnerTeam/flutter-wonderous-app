import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// Simple sprite sheet helper.
// todo: update to make length optional and precalculate some values.
class SpriteSheet {
  ui.Image? image; // null until the ImageProvide finishes loading.
  late double _frameWidth; // if 0, will use image width
  late double _frameHeight; // if 0, will use image height
  late int _length; // if 0, will be calculated from image size
  double scale;
  int _cols = 0;

  SpriteSheet({
    required ImageProvider image,
    int frameWidth = 0,
    int frameHeight = 0,
    int length = 0,
    this.scale = 1.0,
  }) {
    _frameWidth = frameWidth + 0.0;
    _frameHeight = frameHeight + 0.0;
    _length = length;

    // Resolve the provider into a stream, then listen for it to complete.
    // This will happen synchronously if it's already loaded into memory.
    ImageStream stream = image.resolve(ImageConfiguration());
    stream.addListener(ImageStreamListener((info, _) {
      _onImageLoaded(info.image);
    }));
  }

  int get length => _length;

  // Given a frame index, return the rect that describes that frame in the image.
  Rect getFrame(int index) {
    if (image == null || index < 0) return Rect.zero;

    index = index % length;
    int x = index % _cols;
    int y = (index / _cols).floor();

    return Rect.fromLTWH(
        x * _frameWidth, y * _frameHeight, _frameWidth, _frameHeight);
  }

  void _onImageLoaded(ui.Image img) {
    image = img;
    // pre-calculate frame info:
    if (_frameWidth == 0) _frameWidth = img.width + 0.0;
    if (_frameHeight == 0) _frameHeight = img.height + 0.0;
    _cols = (img.width / _frameWidth).floor();
    if (_length == 0) _length = _cols * (img.height / _frameHeight).floor();
  }
}
