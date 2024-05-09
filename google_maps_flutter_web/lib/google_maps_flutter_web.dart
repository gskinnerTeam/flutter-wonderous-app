// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

/// A noop implementation of [GoogleMapsFlutterPlatform].
///
/// This class sets GoogleMapsFlutterPlatform.instance to a noop class that throws
/// for every method.
///
/// Usages of Google Maps should be gated by conditional imports, so this code is
/// never called in the platforms (web) that it disables.
class NoopGoogleMapsPlugin extends GoogleMapsFlutterPlatform {
  /// Registers this class as the default instance of [GoogleMapsFlutterPlatform].
  static void registerWith(Registrar registrar) {
    GoogleMapsFlutterPlatform.instance = NoopGoogleMapsPlugin();
  }
}
