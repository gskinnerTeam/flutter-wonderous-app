import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wonders/main.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  testWidgets('Smoke test', (tester) async {
    registerSingletons();
    await tester.pumpWidget(WondersApp()); // Create main app
    await appLogic.bootstrap();
    await tester.pump(Duration(seconds: 2)); // Render another frame in 2s
    await tester.pump(Duration(seconds: 2)); // Render another frame in 2s
    await tester.pump(Duration(seconds: 2)); // Render another frame in 2s
  });
}
