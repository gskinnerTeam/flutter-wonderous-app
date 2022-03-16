import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wonders/main.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  testWidgets('Smoke test', (WidgetTester tester) async {
    registerSingletons(useMocks: true);
    await tester.pumpWidget(WondersApp()); // Create main app
    app.bootstrap();
    await tester.pump(Duration(seconds: 2)); // Render another frame in 2s
  });
}
