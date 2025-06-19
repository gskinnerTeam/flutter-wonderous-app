import 'package:flutter/widgets.dart';
import 'package:flutterrific_opentelemetry/flutterrific_opentelemetry.dart';

/// Custom navigator observer that records metrics about page navigation
class WonderMetricsObserver extends OTelNavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    
    // Record metrics about this navigation
    final routeName = route.settings.name;
    final prevRouteName = previousRoute?.settings.name;
    
    if (routeName != null) {
      // Record page visit as a metric
      FlutterOTelMetrics.recordMetric(
        name: 'page.visit',
        value: 1,
        metricType: 'counter',
        attributes: {
          'page.name': routeName,
          'page.previous': prevRouteName ?? 'none',
          'navigation.type': 'push',
        },
      );
      
      // Start measuring page load time
      _startPageLoadTimer(routeName);
    }
  }
  
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    
    final routeName = previousRoute?.settings.name;
    final prevRouteName = route.settings.name;
    
    if (routeName != null) {
      // Record page return as a metric
      FlutterOTelMetrics.recordMetric(
        name: 'page.return',
        value: 1,
        metricType: 'counter',
        attributes: {
          'page.name': routeName,
          'page.previous': prevRouteName ?? 'none',
          'navigation.type': 'pop',
        },
      );
    }
  }
  
  // Page load tracking
  final Map<String, DateTime> _pageLoadStartTimes = {};
  
  void _startPageLoadTimer(String routeName) {
    _pageLoadStartTimes[routeName] = DateTime.now();
    
    // Schedule measurement for after the frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measurePageLoadTime(routeName);
    });
  }
  
  void _measurePageLoadTime(String routeName) {
    final startTime = _pageLoadStartTimes[routeName];
    if (startTime == null) return;
    
    final loadDuration = DateTime.now().difference(startTime);
    
    // Record the page load time
    FlutterOTelMetrics.recordMetric(
      name: 'page.load_time',
      value: loadDuration.inMilliseconds,
      unit: 'ms',
      metricType: 'histogram',
      attributes: {
        'page.name': routeName,
      },
    );
    
    _pageLoadStartTimes.remove(routeName);
  }
}
