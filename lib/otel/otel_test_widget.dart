import 'package:flutter/material.dart';
import 'package:flutterrific_opentelemetry/flutterrific_opentelemetry.dart';

/// A test widget that demonstrates OpenTelemetry metrics and traces
/// Add this to your app to generate visible telemetry data
class OTelTestWidget extends StatefulWidget {
  const OTelTestWidget({super.key});

  @override
  State<OTelTestWidget> createState() => _OTelTestWidgetState();
}

class _OTelTestWidgetState extends State<OTelTestWidget> {
  int _testCount = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _sendInitializationTrace();
  }

  void _sendInitializationTrace() {
    // Create a span for widget initialization
    final span = FlutterOTel.tracer.startSpan(
      'otel_test_widget.initialization',
      attributes: {
        'widget.type': 'OTelTestWidget',
        'widget.lifecycle': 'initState',
        'platform': 'flutter_web',
      }.toAttributes(),
    );

    // Simulate some initialization work
    Future.delayed(const Duration(milliseconds: 100), () {
      span.addAttributes({
        'initialization.completed': true,
        'initialization.duration_ms': 100,
      }.toAttributes());
      
      span.setStatus(SpanStatusCode.Ok);
      span.end();
      
      // Force flush to ensure span is sent
      FlutterOTel.forceFlush();
    });
  }

  Future<void> _simulateAsyncOperation() async {
    setState(() {
      _isLoading = true;
    });

    // Start a span for the async operation
    final operationSpan = FlutterOTel.tracer.startSpan(
      'otel_test_widget.async_operation',
      attributes: {
        'operation.type': 'simulated_async',
        'operation.id': DateTime.now().millisecondsSinceEpoch.toString(),
        'user.action': 'button_press',
      }.toAttributes(),
    );

    try {
      // Create a child span for the actual work
      final workSpan = FlutterOTel.tracer.startSpan(
        'async_operation.work_simulation',
        parentSpan: operationSpan,
        attributes: {
          'work.type': 'data_processing',
          'work.complexity': 'medium',
        }.toAttributes(),
      );

      // Simulate some work
      await Future.delayed(const Duration(milliseconds: 500));

      // Add more attributes based on the work done
      workSpan.addAttributes({
        'work.items_processed': 42,
        'work.success': true,
      }.toAttributes());

      workSpan.setStatus(SpanStatusCode.Ok);
      workSpan.end();

      // Update the parent span
      operationSpan.addAttributes({
        'operation.result': 'success',
        'operation.items_count': 42,
      }.toAttributes());

      operationSpan.setStatus(SpanStatusCode.Ok);

      // Send a metric for this operation
      FlutterMetricReporter().reportPerformanceMetric(
        'otel_test_async_operation',
        const Duration(milliseconds: 500),
        attributes: {
          'operation_type': 'simulated_async',
          'success': true,
          'items_processed': 42,
        },
      );

      setState(() {
        _testCount++;
        _isLoading = false;
      });

    } catch (error, stackTrace) {
      // Record the error in the span
      operationSpan.recordException(error, stackTrace: stackTrace);
      operationSpan.setStatus(SpanStatusCode.Error, error.toString());
      
      setState(() {
        _isLoading = false;
      });
    } finally {
      operationSpan.end();
      FlutterOTel.forceFlush();
    }
  }

  void _recordUserInteraction(String interactionType) {
    // Record user interaction using the built-in method
    FlutterOTel.tracer.recordUserInteraction(
      'otel_test_widget',
      InteractionType.tap,
      targetName: interactionType,
      responseTime: const Duration(milliseconds: 50),
      attributes: {
        'interaction.count': _testCount,
        'widget.state': _isLoading ? 'loading' : 'idle',
      }.toAttributes(),
    );

    // TODO Send a counter metric
    // FlutterMetricReporter().reportCounter(
    //   'user_interactions_total',
    //   1,
    //   attributes: {
    //     'interaction_type': interactionType,
    //     'widget': 'otel_test_widget',
    //   },
    // );
  }

  void _simulateError() {
    final span = FlutterOTel.tracer.startSpan(
      'otel_test_widget.error_simulation',
      attributes: {
        'test.type': 'error_handling',
        'error.intentional': true,
      }.toAttributes(),
    );

    try {
      // Intentionally throw an error for testing
      throw Exception('This is a test error for OpenTelemetry tracing');
    } catch (error, stackTrace) {
      // Record the error in telemetry
      FlutterOTel.reportError(
        'otel_test_widget.error_simulation',
        error,
        stackTrace,
        attributes: {
          'error.source': 'user_triggered',
          'error.test': true,
        },
      );

      span.recordException(error, stackTrace: stackTrace);
      span.setStatus(SpanStatusCode.Error, error.toString());

      // Show snackbar to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Test error recorded in OpenTelemetry!'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } finally {
      span.end();
      FlutterOTel.forceFlush();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🔍 OpenTelemetry Test Widget',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Test operations completed: $_testCount'),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _recordUserInteraction('async_operation');
                      _simulateAsyncOperation();
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Run Async Operation'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      _recordUserInteraction('error_test');
                      _simulateError();
                    },
                    icon: const Icon(Icons.error),
                    label: const Text('Simulate Error'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      _recordUserInteraction('trace_navigation');
                      // Navigate to trigger navigation traces
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const _TestDetailsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.navigation),
                    label: const Text('Test Navigation'),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            const Text(
              'Check Grafana for traces and metrics:\n'
              '• Metrics: {service_name="wondrous-flutterotel"}\n'
              '• Traces: service.name = wondrous-flutterotel',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Send a disposal trace
    final span = FlutterOTel.tracer.startSpan(
      'otel_test_widget.disposal',
      attributes: {
        'widget.lifecycle': 'dispose',
        'test.operations_completed': _testCount,
      }.toAttributes(),
    );
    
    span.setStatus(SpanStatusCode.Ok);
    span.end();
    FlutterOTel.forceFlush();
    
    super.dispose();
  }
}

class _TestDetailsScreen extends StatelessWidget {
  const _TestDetailsScreen();

  @override
  Widget build(BuildContext context) {
    // Send a screen view trace
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterMetricReporter().reportPerformanceMetric(
        'screen_load_test_details',
        const Duration(milliseconds: 150),
        attributes: {
          'screen': 'test_details',
          'navigation_type': 'push',
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Details'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 64,
              color: Colors.green,
            ),
            SizedBox(height: 16),
            Text(
              'Navigation Trace Recorded!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'This screen load should appear in your traces.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
