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
        let accentColor:Color = Color("AccentColor")
        let progress = 7.0 / 32.0;
        let image = bundle.appending(path: "/assets/images/widget/wonderous-icon.png").path();
        let content = VStack{
            HStack {
                if(showTitle) {
                    Text("Collection").foregroundColor(accentColor)
                }
                Spacer();
                if(showIcon || true) {
                    Image(uiImage: UIImage(contentsOfFile: image)!)
                        .resizable().scaledToFit().frame(height: 24)
                }
            }
            Spacer();
            HStack {
                if(showTitleAndDesc) {
                    VStack(alignment: .leading){
                        Text("Wonderous")
                            .font(.system(size: 22))
                            .foregroundColor(accentColor);
                        Text("Search for hidden artifacts")
                            .font(.system(size: 15))
                            .foregroundColor(Color("GreyMediumColor"));
                    }
                }
                Spacer();
                ZStack{
                    ProgressView(value: progress)
                        .progressViewStyle(
                            GaugeProgressStyle(color: accentColor)
                        )
                        .frame(width: 48, height: 48)
                    Text("\(Int(progress * 100))%").font(.system(size: 12)).foregroundColor(accentColor)
                }
            }
            //NetImage(imageData: netImgData)
        }.widgetURL(URL(string: "wonderous://collections"))
        
        ZStack{
            BgImage(entry: entry)
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0), .black]),
                startPoint: .center,
                endPoint: .bottom)
            switch(family) {
            case .systemSmall:
                content.padding(16)
            case .systemMedium:
                content.padding(24)
            default:
                content.padding(32)
            }
            
        }
        
    }
}
