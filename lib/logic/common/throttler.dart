import 'dart:async';

import 'package:flutter/material.dart';

class Throttler {
  Throttler(this.interval);
  final Duration interval;

  VoidCallback? _action;
  Timer? _timer;

  void call(VoidCallback action, {bool immediateCall = true}) {
    // Let the latest action override whatever was there before
    _action = action;
    // If no timer is running, we want to start one
    if (_timer == null) {
      //  If immediateCall is true, we handle the action now
      if (immediateCall) {
        _callAction();
      }
      // Start a timer that will temporarily throttle subsequent calls, and eventually make a call to whatever _action is (if anything)
      _timer = Timer(interval, _callAction);
    }
  }

  void _callAction() {
    _action?.call(); // If we have an action queued up, complete it.
    _timer = null;
  }

  void reset() {
    _action = null;
    _timer = null;
  }
}
