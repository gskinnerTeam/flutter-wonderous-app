import 'package:flutter/cupertino.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/modals//fullscreen_video_viewer.dart';
import 'package:wonders/ui/common/modals/fullscreen_maps_viewer.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_screen.dart';
import 'package:wonders/ui/screens/artifact/artifact_details/artifact_details_screen.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_screen.dart';
import 'package:wonders/ui/screens/collection/collection_screen.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';
import 'package:wonders/ui/screens/intro/intro_screen.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonders_details_screen.dart';

/// Shared paths / urls used across the app
class ScreenPaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';

  static String settings = '/settings';

  // editorial
  static String wonderDetails(WonderType type, {required int tabIndex}) => '$home/wonder/${type.name}?t=$tabIndex';
  // add /home/wonderType/
  static String video(String id, {String? currentPath}) {
    var value = '${currentPath ?? ''}/video/$id';
    // if(currentPath != null) {
    //
    //   value = '${context.go}/$value';
    // }
    return value;
  }

  static String search(WonderType type) => '/search/${type.name}';
  static String maps(WonderType type) => '/maps/${type.name}';

  // both home/timeline and /home/wonderType/timeline
  static String timeline(WonderType? type) => '/timeline?type=${type?.name ?? ''}';

  // /collection, /search, /carousel, this should be a dialog... but then it can't be deep-linked?
  static String artifact(String id) => '/artifact/$id';

  static String collection(String id) => '/collection?id=$id';
}

// Routes that are used multiple times
AppRoute get _artifactRoute => AppRoute(
      'artifact/:id',
      (s) => ArtifactDetailsScreen(artifactId: s.pathParameters['id']!),
    );

AppRoute get _timelineRoute {
  return AppRoute(
    'timeline',
    (s) => TimelineScreen(type: _tryParseWonderType(s.uri.queryParameters['type']!)),
  );
}

AppRoute get _collectionRoute {
  return AppRoute(
    'collection',
    (s) => CollectionScreen(fromId: s.uri.queryParameters['id'] ?? ''),
    routes: [
      _artifactRoute,
    ],
  );
}

/// Routing table, matches string paths to UI Screens, optionally parses params from the paths
final appRouter = GoRouter(
  redirect: _handleRedirect,
  routes: [
    ShellRoute(
        builder: (context, router, navigator) {
          return WondersAppScaffold(child: navigator);
        },
        routes: [
          AppRoute(ScreenPaths.splash, (_) => Container(color: $styles.colors.greyStrong)), // This will be hidden
          AppRoute(ScreenPaths.intro, (_) => IntroScreen()),
          AppRoute(ScreenPaths.home, (_) => HomeScreen(), routes: [
            AppRoute(
              'wonder/:type',
              (s) {
                int tab = int.tryParse(s.uri.queryParameters['t'] ?? '') ?? 0;
                return WonderDetailsScreen(
                  type: _parseWonderType(s.pathParameters['type']),
                  tabIndex: tab,
                );
              },
              useFade: true,
              // Wonder sub-routes
              routes: [
                _timelineRoute,
                _collectionRoute,
                // Youtube Video
                AppRoute('video/:id', (s) {
                  return FullscreenVideoViewer(id: s.pathParameters['id']!);
                }),

                // Search
                AppRoute(
                  'search/:type',
                  (s) {
                    return ArtifactSearchScreen(type: _parseWonderType(s.pathParameters['type']));
                  },
                  routes: [
                    _artifactRoute,
                  ],
                ),

                // Maps
                AppRoute('maps/:type', (s) {
                  return FullscreenMapsViewer(type: _parseWonderType(s.pathParameters['type']));
                }),
              ],
            ),
          ]),
        ]),
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

String? get initialDeeplink => _initialDeeplink;
String? _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.uri.path != ScreenPaths.splash) {
    debugPrint('Redirecting from ${state.uri.path} to ${ScreenPaths.splash}');
    _initialDeeplink ??= state.uri.toString();
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to: ${state.uri.path}');
  return null; // do nothing
}

WonderType _parseWonderType(String? value) {
  const fallback = WonderType.chichenItza;
  if (value == null) return fallback;
  return _tryParseWonderType(value) ?? fallback;
}

WonderType? _tryParseWonderType(String value) => WonderType.values.asNameMap()[value];
