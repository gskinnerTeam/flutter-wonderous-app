import Foundation

struct FlutterImages {
    static let bgEmpty = getAssetPath("/assets/images/widget/background-empty.jpg")
    static let icon = getAssetPath("/assets/images/widget/wonderous-icon.png")
}

func getAssetPath(_ path : String) -> String {
    return assetBundleUrl.appending(path: path).path()
}

// Returns a file path to the location of the flutter assetBundle
var assetBundleUrl: URL {
    let bundle = Bundle.main
    if bundle.bundleURL.pathExtension == "appex" {
        // Peel off two directory levels - MY_APP.app/PlugIns/MY_APP_EXTENSION.appex
        var url = bundle.bundleURL.deletingLastPathComponent().deletingLastPathComponent()
        url.append(component: "Frameworks/App.framework/flutter_assets")
        return url
    }
    return bundle.bundleURL
}
