import 'dart:convert';
import 'package:flutterrific_opentelemetry/flutterrific_opentelemetry.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '3f4d6e7bf868e5d14487ff4c06466e36'; // Replace with actual OpenWeatherMap API key
  final FlutterMetricReporter _reporter = FlutterMetricReporter();

  Future<Map<String, dynamic>> getWeatherForLocation(double lat, double lon) async {
    final stopwatch = Stopwatch()..start();

    try {
      final url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      _reporter.reportPerformanceMetric(
        'weather_api_call',
        stopwatch.elapsed,
        attributes: {
          'status_code': response.statusCode,
          'latitude': lat,
          'longitude': lon,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e, stackTrace) {
      _reporter.reportError(
        'Weather API Error',
        stackTrace: stackTrace,
        attributes: {
          'latitude': lat,
          'longitude': lon,
          'error_message': e.toString(),
        },
      );
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }
}
