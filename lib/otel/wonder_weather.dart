import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutterrific_opentelemetry/flutterrific_opentelemetry.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/otel/weather/weather_service.dart';
import 'package:wonders/otel/weather/wonder_locations.dart';

class WonderWeather extends StatefulWidget {
  final WonderData data;

  const WonderWeather({Key? key, required this.data}) : super(key: key);

  @override
  State<WonderWeather> createState() => _WonderWeatherState();
}

class _WonderWeatherState extends State<WonderWeather> {
  Map<String, dynamic>? _weatherData;
  String? _error;
  final _weatherService = WeatherService();
  final _metricReporter = FlutterMetricReporter();
  DateTime? _lastRefreshTime;

  final Color errorRed = const Color(0xFFD55161);

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _makeErrors() async {
    try {
      throw Exception('Synchronous error: Something went wrong!');
    } catch (e, stack) {
      FlutterOTel.reportError('Synchronous Error', e, stack);
    }

    Future.delayed(Duration(seconds: 1), () {
      try {
        throw Exception('Asynchronous error: Delayed crash!');
      } catch (e, stack) {
        FlutterOTel.reportError('Asynchronous Error', e, stack);
      }
    });

    // 3. Isolate Error - Runs in a separate Dart Isolate
    final receivePort = ReceivePort();
    Isolate.spawn(_isolateError, receivePort.sendPort);

    _futureFailureNoCatch();
  }

  void _isolateError(SendPort sendPort) {
    try {
      throw Exception('Isolate error: Crash in background thread!');
    } catch (e, stack) {
      FlutterOTel.reportError('Isolate Error', e, stack);
    }
  }

  Future<void> _futureFailureNoCatch() async {
    Future.error(Exception('Unhandled Future Error'));
  }

  Future<void> _loadWeatherData() async {
    final startTime = DateTime.now();
    try {
      final location = wonderLocations[widget.data.type];
      if (location == null) {
        setState(() => _error = 'Location not found');
        _metricReporter.reportError(
          'Weather location not found',
          attributes: {'wonder': widget.data.title},
        );
        return;
      }

      final weatherData = await _weatherService.getWeatherForLocation(
        location.latitude,
        location.longitude,
      );

      setState(() {
        _weatherData = weatherData;
        _error = null;
        _lastRefreshTime = DateTime.now();
      });

      _metricReporter.reportPerformanceMetric(
        'weather_data_load',
        DateTime.now().difference(startTime),
        attributes: {
          'wonder': widget.data.title,
          'success': true,
          'has_data': true,
        },
      );
    } catch (e, stack) {
      setState(() => _error = 'Unable to load weather data');
      _metricReporter.reportError(
        'Weather API Error',
        stackTrace: stack,
        attributes: {
          'wonder': widget.data.title,
          'error': e.toString(),
        },
      );
    }
  }

  String get _formattedTemperature {
    if (_weatherData == null || !_weatherData!.containsKey('main'))
      return '--°C';
    return '${_weatherData!['main']['temp'].round()}°C';
  }

  String get _weatherDescription {
    if (_weatherData == null || !_weatherData!.containsKey('weather'))
      return 'Unknown';
    return _weatherData!['weather'][0]['description'] ?? 'Unknown';
  }

  String get _formattedHumidity {
    if (_weatherData == null || !_weatherData!.containsKey('main'))
      return '--%';
    return '${_weatherData!['main']['humidity']}%';
  }

  String get _lastUpdated {
    if (_lastRefreshTime == null) return '';
    final difference = DateTime.now().difference(_lastRefreshTime!);
    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes == 1) return '1 minute ago';
    return '${difference.inMinutes} minutes ago';
  }

  @override
  Widget build(BuildContext context) {
    return MetricCollector(
      componentName: 'WonderWeather-${widget.data.type}',
      child: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        decoration: BoxDecoration(
          color: $styles.colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular($styles.corners.sm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.wb_sunny,
                        color: $styles.colors.accent1, size: 24),
                    Gap($styles.insets.xs),
                    Text(
                      'Current Weather',
                      style: $styles.text.body
                          .copyWith(color: $styles.colors.white),
                    ),
                  ],
                ),
                if (_error == null)
                  IconButton(
                    icon: Icon(Icons.refresh, color: $styles.colors.accent1),
                    onPressed: _loadWeatherData,
                    tooltip: 'Refresh weather data',
                  ),
              ],
            ),
            Gap($styles.insets.xs),
            if (_error != null)
              Text(
                _error!,
                style:
                    $styles.text.body.copyWith(color: errorRed),
              )
            else if (_weatherData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formattedTemperature,
                        style: $styles.text.h2.copyWith(
                          color: $styles.colors.white,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        _weatherDescription.toUpperCase(),
                        style: $styles.text.body.copyWith(
                          color: $styles.colors.accent1,
                        ),
                      ),
                    ],
                  ),
                  Gap($styles.insets.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(
                          Icons.water_drop,
                          color: $styles.colors.accent2,
                          size: 16,
                        ),
                        Gap($styles.insets.xxs),
                        Text(
                          'Humidity: $_formattedHumidity',
                          style: $styles.text.body.copyWith(
                            color: $styles.colors.white,
                          ),
                        ),
                      ]),
                      IconButton(
                        icon: Icon(Icons.error, color: $styles.colors.accent1),
                        onPressed: _makeErrors,
                        tooltip: 'Create Error for OTel',
                      ),
                    ],
                  ),
                  Gap($styles.insets.xs),
                  Text(
                    'Updated $_lastUpdated',
                    style: $styles.text.caption.copyWith(
                      color: $styles.colors.accent2,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            else
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation($styles.colors.accent1),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
