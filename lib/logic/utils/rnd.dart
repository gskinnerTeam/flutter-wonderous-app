import 'dart:math';
import 'package:flutter/material.dart';

int _seed = DateTime.now().millisecondsSinceEpoch;

/// Globally accessible instance of `Random`.
/// Makes using random values as easy as `rnd(20)` or `rnd.getBool()`.
Random rnd = Random(_seed);

/// Sets the seed of the `rnd` global `Random` instance.
set rndSeed(int seed) => rnd = Random(_seed = seed);

/// Gets the seed of the `rnd` global `Random` instance.
int get rndSeed => _seed;

/// A collection of helpful extensions for the dart:math Random class.
extension RndExtensions on Random {
  /// Allows you to call a Random instance directly to get a random `double` between min and max.
  /// If only one param is passed, a value between 0 and it is returned. Ex. `rnd(10)` returns 0-10.
  /// If no params are passed, a value between 0 and 1 is returned. Ex. `rnd()` returns 0-1.
  double call([double? min, double? max]) {
    if (max == null) {
      max = min ?? 1.0;
      min = 0.0;
    }
    return getDouble(min ?? 0.0, max);
  }

  /// Returns a random `int` between min and max.
  /// Optionally transformed with the specified `Curve`.
  /// For example, passing `Curves.slowMiddle` would favor numbers in the middle of the range.
  int getInt(int min, int max, {Curve? curve}) {
    return curve == null ? min + nextInt(max - min) : getDouble(min * 1.0, max * 1.0, curve: curve).toInt();
  }

  /// Returns a random `double` between min and max.
  /// Optionally transformed with the specified `Curve`.
  /// For example, passing `Curves.easeIn` would favor numbers closer to `min`.
  double getDouble(double min, double max, {Curve? curve}) {
    return curve == null ? min + nextDouble() * (max - min) : min + curve.transform(nextDouble()) * (max - min);
  }

  /// Returns a `bool`, where `chance` specifies the chance of returning `true`.
  /// For example, `getBool(0.8)`, would have an 80% chance to return `true`.
  bool getBool([double chance = 0.5]) {
    return nextDouble() < chance;
  }

  /// Returns `0` or `1`, where `chance` specifies the chance of it returning `1`.
  /// For example, `getBit(0.8)`, would have an 80% chance to return `1`.
  int getBit([double chance = 0.5]) {
    return nextDouble() < chance ? 1 : 0;
  }

  /// Returns `-1` or `1`, where `chance` specifies the chance of it returning `1`.
  /// For example, `getSign(0.8)`, would have an 80% chance to return `1`.
  int getSign([double chance = 0.5]) {
    return nextDouble() < chance ? 1 : -1;
  }

  /// Returns a random `double` between `0` and `360`.
  double getDeg() {
    return nextDouble() * 360.0;
  }

  /// Returns a random `double` between `0` and `pi * 2`.
  double getRad() {
    return nextDouble() * pi * 2.0;
  }

  /// Returns a random Color, based on the specified parameters.
  /// By default, it will return an opaque random color.
  /// Each color component (alpha, hue, saturation, lightness) can either have a specific value set,
  /// or a min to max range.
  ///
  /// The hue component also supports a `hueRange` parameter that is used
  /// with `hue` to calculate a min and max value (hue +/- hueRange).
  ///
  /// For example, if you wanted a bright red random color, you could use:
  ///
  /// `getColor({hue: Hue.red, hueRange: 30, minSaturation: 0.8, lightness: 0.5})`
  ///
  /// This would return a color with an alpha of 1.0 (the default), a random hue of +/- 30 deg of red,
  /// a saturation between 0.8 and 1.0, and a lightness of exactly 0.5.
  Color getColor({
    double? alpha,
    double minAlpha = 1.0,
    double maxAlpha = 1.0,
    double? hue,
    double hueRange = 0.0,
    double minHue = 0.0,
    double maxHue = 360.0,
    double? saturation,
    double minSaturation = 0.0,
    double maxSaturation = 1.0,
    double? lightness,
    double minLightness = 0.0,
    double maxLightness = 1.0,
  }) {
    minHue = (hue == null ? minHue : hue - hueRange) % 360;
    maxHue = (hue == null ? maxHue : hue + hueRange) % 360;
    if (minHue > maxHue) {
      minHue -= 360;
    }

    return HSLColor.fromAHSL(alpha ?? getDouble(minAlpha, maxAlpha), getDouble(minHue, maxHue) % 360,
            saturation ?? getDouble(minSaturation, maxSaturation), lightness ?? getDouble(minLightness, maxLightness))
        .toColor();
  }

  /// Returns a random item from the specified `List`.
  /// If `remove` is true, the item is removed from the list.
  /// Optionally transformed with the specified `Curve`.
  /// For example, passing `Curves.easeOut` would favor items toward the end of the list.
  dynamic getItem(List list, {Curve? curve, bool remove = false}) {
    final int i = getInt(0, list.length, curve: curve);
    return remove ? list.removeAt(i) : list[i];
  }

  /// Randomizes the order of the specified `List`.
  /// If `copy` is true, returns a shuffled copy of the list, if false, it shuffles and returns the original.
  List<T> shuffle<T>(List<T> list, {bool copy = false}) {
    if (copy) {
      list = [...list];
    }
    for (int i = 0, l = list.length; i < l; i++) {
      int j = nextInt(l);
      if (j == i) {
        continue;
      }
      T item = list[j];
      list[j] = list[i];
      list[i] = item;
    }
    return list;
  }
}

/// Hue values for primary and secondary colors. For use with `getColor()`.
class Hue {
  static double red = 0.0;
  static double green = 120.0;
  static double blue = 240.0;

  static double yellow = 60.0;
  static double cyan = 180.0;
  static double magenta = 300.0;
}
