import 'package:advanced_navigator/advanced_navigator.dart';
import 'package:wonders/common_libs.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/a',
  routes: <RouteBase>[
    GoRoute(
      path: '/a',
      builder: (BuildContext context, GoRouterState state) => Screen(name: 'A'),
    ),
    GoRoute(
      path: '/b',
      builder: (BuildContext context, GoRouterState state) => Screen(name: 'B'),
    ),
    GoRoute(
      path: '/c',
      builder: (BuildContext context, GoRouterState state) => Screen(name: 'C'),
    ),
  ],
);

/// The main app.
class NavSpikeApp extends StatelessWidget {
  const NavSpikeApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(routerConfig: _router);
}

/// The home screen
class Screen extends StatelessWidget {
  const Screen({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    void navigate(String name) => context.push(name);

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name, style: TextStyle(fontSize: 48)),
            ElevatedButton(onPressed: () => navigate('/a'), child: const Text('A')),
            ElevatedButton(onPressed: () => navigate('/b'), child: const Text('B')),
            ElevatedButton(onPressed: () => navigate('/c'), child: const Text('C')),
          ],
        ),
      ),
    );
  }
}
