import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonders/assets.dart';

AdvancedMarker getMapsMarker(LatLng position) => AdvancedMarker(
  markerId: MarkerId('0'),
  position: position,
  icon: AppBitmaps.mapMarker,
);
