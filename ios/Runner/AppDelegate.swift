import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDectGpXKc04T6U5MyccC7L5DVl0xbUFY4")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}

/// Reports the space taken by the iPadOS 26+ window controls (close/minimize/zoom) to Flutter,
/// since they aren't part of the safe area Flutter receives. See lib/logic/common/window_controls.dart.
class WindowControlsFlutterViewController: FlutterViewController {
  private var channel: FlutterMethodChannel?
  private var lastInset: Double?

  override func viewDidLoad() {
    super.viewDidLoad()
    channel = FlutterMethodChannel(name: "wonderous/window_controls", binaryMessenger: binaryMessenger)
    channel?.setMethodCallHandler { [weak self] _, result in result(self?.windowControlsInset ?? 0) }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let inset = windowControlsInset
    if inset != lastInset {
      lastInset = inset
      channel?.invokeMethod("insetChanged", arguments: inset)
    }
  }

  /// Left inset needed beyond the regular safe area, which Flutter already handles.
  private var windowControlsInset: Double {
    guard UIDevice.current.userInterfaceIdiom == .pad else { return 0 }
    #if compiler(>=6.2)
    if #available(iOS 26.0, *) {
      let adapted = view.edgeInsets(for: .safeArea(cornerAdaptation: .horizontal))
      return Double(max(0, adapted.left - view.safeAreaInsets.left))
    }
    #endif
    return 0
  }
}
