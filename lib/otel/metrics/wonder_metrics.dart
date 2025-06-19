import 'package:flutterrific_opentelemetry/flutterrific_opentelemetry.dart';
import 'wonder_metrics_observer.dart';

/// Central metrics service for the Wonderous app
class WonderMetrics {
  static final WonderMetrics _instance = WonderMetrics._();
  static WonderMetrics get instance => _instance;
  
  WonderMetrics._();
  
  /// The metrics observer for navigation events
  final metricsObserver = WonderMetricsObserver();

  /// Record a wonder selection event
  void recordWonderSelect(String wonderName) {
    FlutterOTelMetrics.recordMetric(
      name: 'wonder.select',
      value: 1,
      metricType: 'counter',
      attributes: {
        'wonder.name': wonderName,
      },
    );
  }
  
  /// Record a search action
  void recordSearch(String query, String wonderName, int resultCount) {
    FlutterOTelMetrics.recordMetric(
      name: 'search.perform',
      value: 1,
      metricType: 'counter',
      attributes: {
        'search.query': query,
        'search.wonder': wonderName,
      },
    );
    
    // Also record the number of results
    FlutterOTelMetrics.recordMetric(
      name: 'search.results',
      value: resultCount,
      metricType: 'histogram',
      attributes: {
        'search.wonder': wonderName,
      },
    );
  }
  
  /// Record a user interaction with a wonder
  void recordWonderInteraction(String wonderName, String interactionType) {
    FlutterOTelMetrics.recordMetric(
      name: 'wonder.interaction',
      value: 1,
      metricType: 'counter',
      attributes: {
        'wonder.name': wonderName,
        'interaction.type': interactionType,
      },
    );
  }
  
  /// Record a performance metric
  void recordPerformance(String name, Duration duration, {Map<String, Object>? attributes}) {
    FlutterOTelMetrics.recordMetric(
      name: 'performance.$name',
      value: duration.inMilliseconds,
      unit: 'ms',
      metricType: 'histogram',
      attributes: attributes,
    );
  }
  
  /// Record artifact view
  void recordArtifactView(String artifactId, String wonderName) {
    FlutterOTelMetrics.recordMetric(
      name: 'artifact.view',
      value: 1,
      metricType: 'counter',
      attributes: {
        'artifact.id': artifactId,
        'wonder.name': wonderName,
      },
    );
  }
}
