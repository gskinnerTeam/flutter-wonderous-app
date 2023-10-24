import WidgetKit
import SwiftUI
import Intents

// Defines the view / layout of the widget
struct WonderousWidgetView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    var body: some View {
        let showTitle = family == .systemLarge
        let showIcon = family != .systemSmall
        let showTitleAndDesc = family != .systemSmall
        
        let progress = Double(entry.discoveredCount) / 24.0
        let iconImage = flutterAssetBundle.appending(path: "/assets/images/widget/wonderous-icon.png").path()
        let title:String = entry.title.isEmpty ? "Wonderous" : entry.title;
        let subTitle:String = entry.subTitle.isEmpty ? "Search for hidden artifacts" : entry.subTitle;
        let content = VStack{
            HStack {
                if(showTitle) {
                    Text("Collection")
                        .font(.system(size: 15))
                        .foregroundColor(Colors.offWhiteColor)
                }
                Spacer();
                if(showIcon) {
                    Image(uiImage: UIImage(contentsOfFile: iconImage)!)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                }
            }
            Spacer();
            HStack {
                if(showTitleAndDesc) {
                    VStack(alignment: .leading){
                        Text(title)
                            .font(.system(size: 22))
                            .foregroundColor(.white);
                        Text(subTitle)
                            .font(.system(size: 15))
                            .foregroundColor(Colors.mediumGrey);
                    }
                }
                Spacer();
                ZStack{
                    ProgressView(value: progress)
                        .progressViewStyle(GaugeProgressStyle())
                        .frame(width: 48, height: 48)
                    Text("\(Int(progress * 100))%").font(.system(size: 13)).foregroundColor(.white)
                }
            }
        }
        
        ZStack{
            BgImage(entry: entry)
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0), .black]),
                startPoint: .center,
                endPoint: .bottom)
            content.padding(16)
        }.widgetURL(URL(string: "wonderous://collection"))
        
    }
}

// Todo: Refactor to getFlutterAsset(String path), include /assets, or maybe just getFlutterImage(String path), include assets/images
// Returns a file path to the location of the flutter assetBundle
var flutterAssetBundle: URL {
    let bundle = Bundle.main
    if bundle.bundleURL.pathExtension == "appex" {
        // Peel off two directory levels - MY_APP.app/PlugIns/MY_APP_EXTENSION.appex
        var url = bundle.bundleURL.deletingLastPathComponent().deletingLastPathComponent()
        url.append(component: "Frameworks/App.framework/flutter_assets")
        return url
    }
    return bundle.bundleURL
}
