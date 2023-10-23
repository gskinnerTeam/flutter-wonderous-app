import WidgetKit
import SwiftUI
import Intents

struct Colors {
    static let accentColor:Color = Color(red: 0.89, green: 0.58, blue: 0.36)
    static let offWhiteColor:Color = Color(red: 0.97, green: 0.92, blue: 0.9)
    static let mediumGrey:Color = Color(red: 0.62, green: 0.6, blue: 0.58)
    static let darkGrey:Color = Color(red: 0.32, green: 0.31, blue: 0.3);
}

// Defines the view / layout of the widget
struct WonderousWidgetView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    var body: some View {
        let showTitle = family == .systemLarge
        let showIcon = family != .systemSmall
        let showTitleAndDesc = family != .systemSmall
        
        let progress = Double(entry.discoveredCount) / 24.0
        let iconImage = bundle.appending(path: "/assets/images/widget/wonderous-icon.png").path()
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
