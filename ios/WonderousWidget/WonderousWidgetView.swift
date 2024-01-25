import WidgetKit
import SwiftUI
import Intents

/// Defines the view / layout of the widget
struct WonderousWidgetView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: WonderousTimelineProvider.Entry
    var body: some View {
        let showTitle = family == .systemLarge
        let showIcon = family != .systemSmall
        let showTitleAndDesc = family != .systemSmall
        let progressPct = Double(entry.discoveredCount) / 24.0
        let iconImage = FlutterImages.icon;
        let title = entry.title.isEmpty ? "Wonderous" : entry.title;
        let subTitle = entry.subTitle.isEmpty ? "Search for hidden artifacts" : entry.subTitle;
        
        let content = VStack{
            // Top row with optional Title and Icon
            HStack {
                if(showTitle) {
                    Text("Collection")
                        .font(.system(size: 15))
                        .foregroundColor(.offWhite)
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
            
            // Bottom hz row with title, desc and progress gauge
            HStack {
                if(showTitleAndDesc) {
                    VStack(alignment: .leading){
                        Text(title)
                            .font(.system(size: 22))
                            .foregroundColor(.white);
                        Text(subTitle)
                            .font(.system(size: 15))
                            .foregroundColor(.mediumGrey);
                    }
                }
                Spacer();
                ZStack{
                    ProgressView(value: progressPct)
                        .progressViewStyle(GaugeProgressStyle())
                        .frame(width: 48, height: 48)
                    
                    Text("\(Int((progressPct * 100).rounded()))%").font(.system(size: 13)).foregroundColor(.white)
                }
            }
        }
        
        // Stack content on top of the background image and a gradient
        return ZStack{
            BgImage(entry: entry).opacity(0.8)
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0), .black]),
                startPoint: .center,
                endPoint: .bottom)
            content.padding(16)
        }
        // Ios requires that widgets have a background color
        .widgetBackground(Color.darkGrey)
        // Deeplink into collections view when tapped
        .widgetURL(URL(string: "wonderous:///home/collection"))
        
    }
}

