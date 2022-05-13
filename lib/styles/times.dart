import 'package:flutter/material.dart';

@immutable
class AppTimes {
  final Duration fast = Duration(milliseconds: 300);
  final Duration med = Duration(milliseconds: 600);
  final Duration slow = Duration(milliseconds: 900);
  // TODO: do a pass, and consolidate any initial delays that are close to this
  final Duration pageTransition = Duration(milliseconds: 200);
}
