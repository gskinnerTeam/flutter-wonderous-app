import Foundation
import SwiftUI


// Loads a default image from the flutter assets bundle,
// or  displays a base64 encoded image that has been saved from the flutter application
struct BgImage : View {
    var entry: WonderousEntry
    var body: some View {
        var uiImage:UIImage?;
        if(entry.imageData.isEmpty){
            let defaultImage = flutterAssetBundle.appending(path: "/assets/images/widget/background-empty.jpg").path();
            uiImage = UIImage(contentsOfFile: defaultImage);
        } else {
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
                .stroke(Colors.darkGrey, style: StrokeStyle(lineWidth: 2))
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(Colors.accent, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(90))
        }
    }
}
