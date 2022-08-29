import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// An image provider that retries if loading the bytes failed.
///
/// Useful for network image requests that may transiently fail.
@immutable
class RetryImage extends ImageProvider<Object> {
  /// Creates an object that uses [imageProvider] to fetch and decode an image,
  /// and retries if fetching fails.
  const RetryImage(this.imageProvider, {this.scale = 1.0, this.maxRetries = 4});

  /// A wrapped image provider to use.
  final ImageProvider imageProvider;

  /// The maximum number of times to retry.
  final int maxRetries;

  /// The scale to place in the [ImageInfo] object of the image.
  ///
  /// Must be the same as the scale argument provided to [imageProvider], if
  /// any.
  final double scale;

  @override
  Future<Object> obtainKey(ImageConfiguration configuration) {
    Completer<Object>? completer;
    // If the imageProvider.obtainKey future is synchronous, then we will be able to fill in result with
    // a value before completer is initialized below.
    SynchronousFuture<Object>? result;
    imageProvider.obtainKey(configuration).then((Object key) {
      if (completer == null) {
        // This future has completed synchronously (completer was never assigned),
        // so we can directly create the synchronous result to return.
        result = SynchronousFuture<Object>(key);
      } else {
        // This future did not synchronously complete.
        completer.complete(key);
      }
    });
    if (result != null) {
      return result!;
    }
    // If the code reaches here, it means the imageProvider.obtainKey was not
    // completed sync, so we initialize the completer for completion later.
    completer = Completer<Object>();
    return completer.future;
  }

  ImageStreamCompleter _commonLoad(ImageStreamCompleter Function() loader) {
    final _DelegatingImageStreamCompleter completer = _DelegatingImageStreamCompleter();
    ImageStreamCompleter completerToWrap = loader();
    late ImageStreamListener listener;

    Duration duration = const Duration(milliseconds: 250);
    int count = 1;
    listener = ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        completer.addImage(image);
      },
      onChunk: completer._reportChunkEvent,
      onError: (Object exception, StackTrace? stackTrace) {
        completerToWrap.removeListener(listener);
        if (count > maxRetries) {
          completer.reportError(exception: exception, stack: stackTrace);
          return;
        }
        Future<void>.delayed(duration).then((void v) {
          duration *= 2;
          completerToWrap = loader();
          count += 1;
          completerToWrap.addListener(listener);
        });
      },
    );
    completerToWrap.addListener(listener);

    completer.addOnLastListenerRemovedCallback(() {
      completerToWrap.removeListener(listener);
    });

    return completer;
  }

  @override
  // ignore: deprecated_member_use
  ImageStreamCompleter load(Object key, DecoderCallback decode) {
    // ignore: deprecated_member_use
    return _commonLoad(() => imageProvider.load(key, decode));
  }

  @override
  ImageStreamCompleter loadBuffer(Object key, DecoderBufferCallback decode) {
    return _commonLoad(() => imageProvider.loadBuffer(key, decode));
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RetryImage && other.imageProvider == other.imageProvider && other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(imageProvider, scale);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'RetryImage')}(imageProvider: $imageProvider, maxRetries: $maxRetries, scale: $scale)';
}

class _DelegatingImageStreamCompleter extends ImageStreamCompleter {
  void addImage(ImageInfo info) {
    setImage(info);
  }

  void _reportChunkEvent(ImageChunkEvent event) {
    reportImageChunkEvent(event);
  }
}
