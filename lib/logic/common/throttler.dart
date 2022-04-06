import 'dart:async';

import 'package:flutter/material.dart';

class Throttler {
  Throttler(this.interval);
  final Duration interval;

  VoidCallback? _action;
  Timer? _timer;

  void call(VoidCallback action, {bool immediateCall = false}) {
    _action = action;
    if (_timer == null) {
      // If no timer is running, and immediateCall is true, just handle the action now
      if (immediateCall) {
        _action?.call();
        _action = null; // Set it to null since we've already handled it
      }
      _timer = Timer(interval, () {
        _action?.call();
        _timer = null;
      });
    }
  }

  void cancelPending() => _action = null;
}
