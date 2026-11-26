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

class WindowControlsFlutterViewController: FlutterViewController {
  private var channel: FlutterMethodChannel?
  private var lastLeft: CGFloat = -1

  override func viewDidLoad() {
    super.viewDidLoad()
    let ch = FlutterMethodChannel(name: "wonderous/window_controls", binaryMessenger: binaryMessenger)
    ch.setMethodCallHandler { [weak self] call, result in
      guard call.method == "getInsets" else { return result(FlutterMethodNotImplemented) }
      result(["left": Double(self?.windowControlsLeftInset() ?? 0)])
    }
    channel = ch
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    pushIfChanged()
  }

  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    pushIfChanged()
  }

  private func windowControlsLeftInset() -> CGFloat {
    guard UIDevice.current.userInterfaceIdiom == .pad else { return 0 }
    #if compiler(>=6.2)
    if #available(iOS 26.0, *) {
      let adapted = view.edgeInsets(for: .safeArea(cornerAdaptation: .horizontal))
      return max(0, adapted.left - view.safeAreaInsets.left)
    }
    #endif
    return 0
  }

  private func pushIfChanged() {
    let left = windowControlsLeftInset()
    guard abs(left - lastLeft) > 0.5 else { return }
    lastLeft = left
    channel?.invokeMethod("insetsChanged", arguments: ["left": Double(left)])
  }
}