import Foundation
import SwiftUI


// Loads a default image from the flutter assets bundle,
// or  displays a base64 encoded image that has been saved from the flutter application
struct BgImage : View {
    var entry: WonderousTimelineEntry
    var body: some View {
        var uiImage:UIImage?;
        // If there is no saved imageData, use the default bg image
        if(entry.imageData.isEmpty){
            let defaultImage = flutterAssetBundle.appending(path: "/assets/images/widget/background-empty.jpg").path();
            uiImage = UIImage(contentsOfFile: defaultImage);
        }
        // Load a base64 encoded image that has been written by the flutter app
        else {
            uiImage = UIImage(data: Data(base64Encoded: entry.imageData)!)
        }
        if(uiImage != nil){
            // Use geometry reader to prevent the image from pushing the other content out of the widgets bounds (https://stackoverflow.com/questions/57593552/swiftui-prevent-image-from-expanding-view-rect-outside-of-screen-bounds)
            let image = GeometryReader { geometry in
                Image(uiImage: uiImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all) // Ignore the safe area
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            }
            return AnyView(image)
        }
        debugPrint("The image file could not be loaded")
        return AnyView(EmptyView())
    }
    
}

struct GaugeProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        return ZStack {
            Circle()
                .stroke(Color.body, style: StrokeStyle(lineWidth: 2))
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(Color.accent, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(90))
        }
    }
}

// Create an extension to support new containerBackground API on
// iOS 17 while still supporting iOS 16 and less (https://nemecek.be/blog/192/hotfixing-widgets-for-ios-17-containerbackground-padding)
extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
