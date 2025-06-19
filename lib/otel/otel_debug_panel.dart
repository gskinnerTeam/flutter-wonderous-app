import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterrific_opentelemetry/flutterrific_opentelemetry.dart';
import 'package:wonders/otel/debug_span_diagnostics.dart';

/// A floating debug panel for OpenTelemetry testing
/// Shows as a small floating button that expands to show test controls
class OTelDebugPanel extends StatefulWidget {
  const OTelDebugPanel({super.key});

  @override
  State<OTelDebugPanel> createState() => _OTelDebugPanelState();
}

class _OTelDebugPanelState extends State<OTelDebugPanel>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  int _testCount = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePanel() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Future<void> _sendTestTrace() async {
    setState(() {
      _isLoading = true;
    });

    final span = FlutterOTel.tracer.startSpan(
      'debug_panel.test_trace',
      attributes: {
        'test.type': 'manual_debug',
        'test.count': _testCount + 1,
        'ui.component': 'debug_panel',
      }.toAttributes(),
    );

    try {
      // Simulate some async work
      await Future.delayed(const Duration(milliseconds: 300));

      // Add some events to the span
      span.addEventNow('test_work_started', {
        'work.type': 'simulation',
      }.toAttributes());

      await Future.delayed(const Duration(milliseconds: 200));

      span.addEventNow('test_work_completed', {
        'work.items': 42,
        'work.success': true,
      }.toAttributes());

      // Update span with final attributes
      span.addAttributes({
        'test.duration_ms': 500,
        'test.result': 'success',
      }.toAttributes());

      span.setStatus(SpanStatusCode.Ok);

      // Send a metric too
      FlutterMetricReporter().reportPerformanceMetric(
        'debug_panel_test_operation',
        const Duration(milliseconds: 500),
        attributes: {
          'test_type': 'manual',
          'operation_count': _testCount + 1,
        },
      );

      setState(() {
        _testCount++;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Test trace #$_testCount sent!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error, stackTrace) {
      span.recordException(error, stackTrace: stackTrace);
      span.setStatus(SpanStatusCode.Error, error.toString());
      
      setState(() {
        _isLoading = false;
      });
    } finally {
      span.end();
      FlutterOTel.forceFlush();
    }
  }

  void _sendTestError() {
    final span = FlutterOTel.tracer.startSpan(
      'debug_panel.test_error',
      attributes: {
        'test.type': 'error_simulation',
        'error.intentional': true,
      }.toAttributes(),
    );

    try {
      throw Exception('Test error from debug panel #${_testCount + 1}');
    } catch (error, stackTrace) {
      FlutterOTel.reportError(
        'debug_panel.test_error',
        error,
        stackTrace,
        attributes: {
          'error.source': 'debug_panel',
          'error.test_number': _testCount + 1,
        },
      );

      span.recordException(error, stackTrace: stackTrace);
      span.setStatus(SpanStatusCode.Error, error.toString());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Test error recorded!'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
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
    return Positioned(
      top: 50,  // Higher up to avoid conflicts
      right: 16,
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: AnimatedBuilder(
            animation: _expandAnimation,
            builder: (context, child) {
              return Container(
                width: _isExpanded ? 200 : 56,
                height: _isExpanded ? 280 : 56,  // Taller when expanded
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange, width: 2),  // Orange border to make it visible
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: _isExpanded ? _buildExpandedPanel() : _buildCollapsedButton(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsedButton() {
    return GestureDetector(
      onTap: _togglePanel,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange, width: 2),
        ),
        child: const Icon(
          Icons.bug_report,
          color: Colors.orange,  // Orange icon to match border
          size: 28,  // Slightly larger
        ),
      ),
    );
  }

  Widget _buildExpandedPanel() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'OTel Debug',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: _togglePanel,
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Tests: $_testCount',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          if (_isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          else
            Column(
              children: [
                _buildActionButton(
                  'Send Trace',
                  Icons.send,
                  _sendTestTrace,
                  Colors.blue,
                ),
                const SizedBox(height: 8),
                _buildActionButton(
                  'Test Error',
                  Icons.error,
                  _sendTestError,
                  Colors.orange,
                ),
                const SizedBox(height: 8),
                _buildActionButton(
                  'Force Flush',
                  Icons.refresh,
                  () {
                    FlutterOTel.forceFlush();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Forced flush!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  Colors.green,
                ),
                const SizedBox(height: 8),
                _buildActionButton(
                  'Diagnostics',
                  Icons.healing,
                  () {
                    if (kDebugMode) {
                      try {
                        // Import and run diagnostics
                        debugPrint('🔍 Running manual diagnostics...');
                        OTelSpanDiagnostics.runFullDiagnostics();
                        
                        // Simple inline diagnostic
                        final tracerProvider = FlutterOTel.tracerProvider;
                        final processorCount = tracerProvider.spanProcessors.length;
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Processors: $processorCount\nCheck console for details'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                        
                        debugPrint('TracerProvider span processors: $processorCount');
                        for (int i = 0; i < processorCount; i++) {
                          debugPrint('  $i: ${tracerProvider.spanProcessors[i].runtimeType}');
                        }
                      } catch (e) {
                        debugPrint('Diagnostic error: $e');
                      }
                    }
                  },
                  Colors.purple,
                ),
              ],
            ),
          const SizedBox(height: 8),
          const Text(
            'Check Grafana:\n• Explore > Tempo\n• service.name=\n  wondrous-flutterotel',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
    Color color,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        label: Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );
  }
}
