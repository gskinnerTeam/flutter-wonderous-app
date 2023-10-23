import Foundation
import SwiftUI


// Loads a default image from the flutter assets bundle,
// or  displays a base64 encoded image
struct BgImage : View {
    var entry: WonderousEntry
    var body: some View {
        var uiImage:UIImage?;
        if(entry.imageData.isEmpty){
            let defaultImage = bundle.appending(path: "/assets/images/widget/background-empty.jpg").path();
            uiImage = UIImage(contentsOfFile: defaultImage);
        } else {
            uiImage = UIImage(data: Data(base64Encoded: entry.imageData)!)
        }
        if(uiImage != nil){
            let image = GeometryReader { geometry in
                Image(uiImage: uiImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all) // Ignore the safe area
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            }
            return AnyView(image)
        }
        print("The image file could not be loaded")
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
                .stroke(Colors.accentColor, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(90))
        }
    }
}
