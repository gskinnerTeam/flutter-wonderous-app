import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/artifact_api_logic.dart';
import 'package:wonders/logic/artifact_api_service.dart';
import 'package:wonders/logic/collectibles_logic.dart';
import 'package:wonders/logic/locale_logic.dart';
import 'package:wonders/logic/native_widget_service.dart';
import 'package:wonders/logic/timeline_logic.dart';
import 'package:wonders/logic/unsplash_logic.dart';
import 'package:wonders/logic/wonders_logic.dart';
import 'package:wonders/ui/common/app_shortcuts.dart';
import 'package:flutterrific_opentelemetry/flutterrific_opentelemetry.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutterrific_opentelemetry/src/util/otel_config.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    }
    // Report error to both spans and metrics (only after OTel is initialized)
    try {
      FlutterOTel.reportError(
          'FlutterError.onError', details.exception, details.stack,
          attributes: {
            'error.source': 'flutter_error',
            'error.type': details.exception.runtimeType.toString(),
          });
    } catch (e) {
      // If OTel isn't initialized yet, just log locally
      if (kDebugMode) {
        debugPrint('OTel not ready for error reporting: $e');
      }
    }
  };

  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep native splash screen up until app is finished bootstrapping
    if (!kIsWeb) {
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    }

    ///Flutterrific OTel initialization
    var sessionId = DateTime.now(); //synthetic session id

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // Enable comprehensive logging for debugging metrics
    OTelLog.metricLogFunction = null;
    OTelLog.exportLogFunction = null;
    OTelLog.spanLogFunction = debugPrint;

    // Platform-specific metric exporter configuration
    late final MetricExporter otlpMetricExporter;
    late final MetricReader metricReader;

    if (kIsWeb) {
      // Web platform - use HTTP exporter
      // Use the base endpoint - exporter will add /v1/metrics automatically
      debugPrint('🌐 WEB PLATFORM: Creating HTTP exporter for ${OTelConfig.endpoint}');
      otlpMetricExporter = OtlpHttpMetricExporter(
        OtlpHttpMetricExporterConfig(
          endpoint: OTelConfig.endpoint,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
          },
        ),
      );
      
      // Shorter interval for web testing
      metricReader = PeriodicExportingMetricReader(
        otlpMetricExporter,
        interval: Duration(seconds: 5), // Export every 5 seconds for web
      );
    } else {
      // Mobile/Desktop - use gRPC exporter
      debugPrint('📱 NATIVE PLATFORM: Creating gRPC exporter');
      otlpMetricExporter = OtlpGrpcMetricExporter(
        OtlpGrpcMetricExporterConfig(
          endpoint: OTelConfig.endpoint,
          insecure: !OTelConfig.secure,
        ),
      );

      metricReader = PeriodicExportingMetricReader(
        otlpMetricExporter,
        interval: Duration(seconds: 3), // Export every 3 seconds for mobile
      );
    }

    // Print configuration for debugging
    OTelConfig.printConfig();
    if (kDebugMode) {
      debugPrint('Using ${kIsWeb ? 'HTTP' : 'gRPC'} exporter for ${kIsWeb ? 'web' : 'native'} platform');
    }

    await FlutterOTel.initialize(
        serviceName: 'wondrous-flutterotel',
        endpoint: OTelConfig.endpoint, // Use configured endpoint for all platforms
        secure: OTelConfig.secure,
        serviceVersion: '1.0.0',
        //configures the default trace, consider making other tracers for isolates, etc.
        tracerName: 'ui',
        tracerVersion: '1.0.0',
        metricExporter: otlpMetricExporter,
        metricReader: metricReader,
        //OTel standard tenant_id, required for Dartastic.io
        tenantId: 'valued-saas-customer-id',
        //required for the Dartastic.io backend
        // dartasticApiKey: '123456',
        resourceAttributes: <String, Object>{
          // Always consult the OTel Semantic Conventions to find an existing
          // convention name for an attribute.  Semantics are evolving.
          // https://opentelemetry.io/docs/specs/semconv/
          //--dart-define environment=dev
          //See https://opentelemetry.io/docs/specs/semconv/resource/deployment-environment/
          EnvironmentResource.deploymentEnvironment.key: 'dev',
          // TODO ...await resourcesForDeviceInfo(deviceInfoPlugin),
          AppInfoSemantics.appName.key: packageInfo.appName,
          AppInfoSemantics.appPackageName.key: packageInfo.packageName,
          AppInfoSemantics.appVersion.key: packageInfo.version,
          AppInfoSemantics.appBuildNumber.key: packageInfo.buildNumber,
          'platform': kIsWeb ? 'web' : Platform.operatingSystem,
        }.toAttributes(),
        commonAttributesFunction: () => <String, Object>{
              // These attributes will usually change over time in a real app,
              // ensure that no null values are included.
              UserSemantics.userId.key: 'wondrousOTelUser1',
              UserSemantics.userRole.key: 'demoUser',
              UserSemantics.userSession.key: sessionId
            }.toAttributes());

    GoRouter.optionURLReflectsImperativeAPIs = true;

  // Start app
  registerSingletons();

    // Send initial test metric to verify connection
    Timer(Duration(seconds: 2), () {
      if (kDebugMode) {
        debugPrint('Sending initial test metric...');
      }
      try {
        // TODO FlutterOTel.reportPerformanceMetric(
        // TODO - string attr names (both places)
        FlutterMetricReporter().reportPerformanceMetric(
          'app_startup_test',
          Duration(milliseconds: 100),
          attributes: {
            'test': true,
            'platform': kIsWeb ? 'web' : Platform.operatingSystem,
            'startup_phase': 'initialization_complete',
          },
        );
        
        // Force flush to ensure the test metric is sent immediately
        OTel.meterProvider().forceFlush();
        
        if (kDebugMode) {
          debugPrint('Test metric sent and flushed');
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Failed to send test metric: $e');
        }
      }
    });

    // Set up a periodic timer to flush metrics (less frequent for production)
    Timer.periodic(Duration(seconds: 10), (_) {
      if (OTelLog.isLogMetrics()) {
        OTelLog.logMetric("Periodic metrics flush");
      }
      try {
        OTel.meterProvider().forceFlush();
        OTel.tracerProvider().forceFlush();
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error during periodic flush: $e');
        }
      }
    });

    runApp(WondersApp());
    await appLogic.bootstrap();

    // Remove splash screen when bootstrap is complete
    FlutterNativeSplash.remove();
  }, (error, stack) {
    if (kDebugMode) {
      debugPrint('$error');
      debugPrintStack(stackTrace: stack, label: 'Flutter app runZoneGuarded');
    }
    try {
      FlutterOTel.reportError('Error caught in run', error, stack, attributes: {
        'error.source': 'zone_error',
        'error.type': error.runtimeType.toString(),
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to report zone error to OTel: $e');
      }
    }
  });
}

Future<Map<String, Object>> resourcesForDeviceInfo(DeviceInfoPlugin deviceInfoPlugin) async {
  try {
    if (!kIsWeb) {
      if (Platform.isIOS) {
        final deviceInfo = await deviceInfoPlugin.iosInfo;
        return {
          DeviceSemantics.deviceId.key: deviceInfo.identifierForVendor ?? 'no_id',
          DeviceSemantics.deviceModel.key: deviceInfo.model,
          DeviceSemantics.devicePlatform.key: deviceInfo.systemName,
          DeviceSemantics.deviceOsVersion.key: deviceInfo.systemVersion,
          DeviceSemantics.isPhysicalDevice.key: deviceInfo.isPhysicalDevice,
        };
      } else if (Platform.isAndroid) {
        final deviceInfo = await deviceInfoPlugin.androidInfo;
        return {
          DeviceSemantics.deviceId.key: deviceInfo.id,
          DeviceSemantics.deviceModel.key: deviceInfo.model,
          DeviceSemantics.devicePlatform.key: deviceInfo.hardware,
          DeviceSemantics.deviceOsVersion.key: deviceInfo.version.release,
          DeviceSemantics.isPhysicalDevice.key: deviceInfo.isPhysicalDevice,
        };
      }
    } else {
      // Web platform device info
      final deviceInfo = await deviceInfoPlugin.webBrowserInfo;
      return {
        DeviceSemantics.devicePlatform.key: 'web',
        'browser.name': deviceInfo.browserName.toString() ?? 'unknown',
        'browser.version': deviceInfo.appVersion ?? 'unknown',
        'user_agent': deviceInfo.userAgent ?? 'unknown',
      };
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Failed to get device info: $e');
    }
  }
  return {};
}

/// Creates an app using the [MaterialApp.router] constructor and the global `appRouter`, an instance of [GoRouter].
class WondersApp extends StatefulWidget with GetItStatefulWidgetMixin {
  WondersApp({super.key});

  @override
  State<WondersApp> createState() => _WondersAppState();
}

class _WondersAppState extends State<WondersApp> with GetItStateMixin {
  @override
  void initState() {
    if (kIsWeb) {
      appLogic.precacheWonderImages(context);
    }
    // Send app launch metric
    Timer(Duration(milliseconds: 500), () {
      try {
        FlutterMetricReporter().reportPerformanceMetric(
          'app_widget_init',
          Duration(milliseconds: 500),
          attributes: {
            'widget': 'WondersApp',
            'platform': kIsWeb ? 'web' : (Platform.isAndroid ? 'android' : 'ios'),
          },
        );
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Failed to report app init metric: $e');
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    try {
      //TODO - should be a mixin or a widget or hidden in FlutterOTel something simpler
      MetricsService.dispose();

      // Force flush before disposing to ensure all metrics are sent
      OTel.meterProvider().forceFlush();
      OTel.tracerProvider().forceFlush();

      if (OTelLog.isLogMetrics()) {
        OTelLog.logMetric("Flushing metrics before app dispose");
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error during app dispose: $e');
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    var routerDelegate = appRouter.routerDelegate;
    return MaterialApp.router(
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      locale: locale == null ? null : Locale(locale),
      debugShowCheckedModeBanner: false,
      routerDelegate: routerDelegate,
      shortcuts: AppShortcuts.defaults,
      theme: ThemeData(fontFamily: $styles.text.body.fontFamily, useMaterial3: true),
      color: $styles.colors.black,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

/// Create singletons (logic and services) that can be shared across the app.
void registerSingletons() {
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
  // Wonders
  GetIt.I.registerLazySingleton<WondersLogic>(() => WondersLogic());
  // Timeline / Events
  GetIt.I.registerLazySingleton<TimelineLogic>(() => TimelineLogic());
  // Search
  GetIt.I.registerLazySingleton<ArtifactAPILogic>(() => ArtifactAPILogic());
  GetIt.I.registerLazySingleton<ArtifactAPIService>(() => ArtifactAPIService());
  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  // Unsplash
  GetIt.I.registerLazySingleton<UnsplashLogic>(() => UnsplashLogic());
  // Collectibles
  GetIt.I.registerLazySingleton<CollectiblesLogic>(() => CollectiblesLogic());
  // Localizations
  GetIt.I.registerLazySingleton<LocaleLogic>(() => LocaleLogic());
  // Home Widget Service
  GetIt.I.registerLazySingleton<NativeWidgetService>(() => NativeWidgetService());
}

/// Add syntax sugar for quickly accessing the main "logic" controllers in the app
/// We deliberately do not create shortcuts for services, to discourage their use directly in the view/widget layer.
AppLogic get appLogic => GetIt.I.get<AppLogic>();
WondersLogic get wondersLogic => GetIt.I.get<WondersLogic>();
TimelineLogic get timelineLogic => GetIt.I.get<TimelineLogic>();
SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();
UnsplashLogic get unsplashLogic => GetIt.I.get<UnsplashLogic>();
ArtifactAPILogic get artifactLogic => GetIt.I.get<ArtifactAPILogic>();
CollectiblesLogic get collectiblesLogic => GetIt.I.get<CollectiblesLogic>();
LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();

/// Global helpers for readability
AppLocalizations get $strings => localeLogic.strings;
AppStyle get $styles => WondersAppScaffold.style;
