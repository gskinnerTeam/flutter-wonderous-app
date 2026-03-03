import 'dart:async';
import 'dart:ui_web' as ui_web;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart' as googleMaps;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web/web.dart' as web;

class GoogleMapsWeb extends StatefulWidget {
  const GoogleMapsWeb({super.key, required this.lat, required this.lng, required this.zoom});
  final double lat;
  final double lng;
  final double zoom;

  @override
  State<GoogleMapsWeb> createState() => _GoogleMapsWebState();
}

class _GoogleMapsWebState extends State<GoogleMapsWeb> {
  late final String _viewType;
  late final web.HTMLDivElement _mapElement;
  googleMaps.Map? _map;
  Object? _marker;
  String? _errorText;
  int _remainingInitAttempts = 25;

  @override
  void initState() {
    super.initState();
    _viewType = 'google-maps-web-${DateTime.now().microsecondsSinceEpoch}';

    _mapElement = web.HTMLDivElement()
      ..id = _viewType
      ..style.width = '100%'
      ..style.height = '100%';

    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) => _mapElement,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMap();
    });
  }

   void _initializeMap() {
    if (_map != null || !kIsWeb) {
      return;
    }

    try {
      final center = googleMaps.LatLng(widget.lat, widget.lng);
      final map = googleMaps.Map(
        _mapElement,
        googleMaps.MapOptions(
          mapId: MarkerId('0').value,
          center: center,
          zoom: 3,
          zoomControl: false,
          mapTypeControl: false,
          streetViewControl: false,
          fullscreenControl: false,
        ),
      );

      _map = map;

      try {
        _marker = googleMaps.AdvancedMarkerElement(
          googleMaps.AdvancedMarkerElementOptions(
            map: map,
            position: center,
            title: 'San Francisco',
          ),
        );
      } catch (_) {
        _marker = googleMaps.Marker(
          googleMaps.MarkerOptions(
            map: map,
            position: center,
            title: 'San Francisco',
          ),
        );
      }
    } catch (error) {
      if (_remainingInitAttempts > 0) {
        _remainingInitAttempts -= 1;
        Timer(const Duration(milliseconds: 250), _initializeMap);
        return;
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _errorText = 'Failed to initialize Google Maps. Check API key + referrer restrictions. Error: $error';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const Center(
        child: Text('GoogleMapWeb is web-only.'),
      );
    }

    if (_errorText != null) {
      return Center(
        child: Text(_errorText!),
      );
    }

    return SizedBox.expand(
      child: HtmlElementView(viewType: _viewType),
    );
  }
}