import WidgetKit
import SwiftUI
import Intents

/// Every home-widget requires a TimelineEntry. This is passed into the view and propvides any data it needs
struct WonderousTimelineEntry : TimelineEntry {
    // Date is a mandatory field for all TimelineEntries
    let date: Date
    // Custom field for the wonderous view
    let discoveredCount:Int;
    var title:String = "";
    var subTitle:String = "";
    var imageData:String = "";
}

/// Widget, defines some high level configuration options as well as the primary view that will display the widget.
struct WonderousWidget: Widget {
    let kind: String = "WonderousWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WonderousTimelineProvider()) { entry in
            WonderousWidgetView(entry: entry)
        }
        .contentMarginsDisabled()
        .configurationDisplayName("Wonderous Widget")
        .description("Track your collected artifacts!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct WonderousConfig {
    let iosKey = "group.com.gskinner.flutter.wonders.widget"
    let discoveredCountKey = "dicoveredCount"
}

/// TimelineProvider, returns various WonderousTimelineEntry configurations for different contexts
struct WonderousTimelineProvider: TimelineProvider {
    // Provide an entry for a placeholder version of the widget
    func placeholder(in context: Context) -> WonderousTimelineEntry {
        WonderousTimelineEntry(date: Date(), discoveredCount: 0)
    }
    
    // Provide an entry for the current time and state of the widget
    func getSnapshot(in context: Context, completion: @escaping (WonderousTimelineEntry) -> ()) {
        let entry:WonderousTimelineEntry
        let userDefaults = UserDefaults(suiteName: "group.com.gskinner.flutter.wonders.widget")
        let discoveredCount = userDefaults?.integer(forKey: "discoveredCount") ?? 0
        let title = userDefaults?.string(forKey: "lastDiscoveredTitle") ?? ""
        let subTitle = userDefaults?.string(forKey: "lastDiscoveredSubTitle") ?? ""
        let imageData = userDefaults?.string(forKey: "lastDiscoveredImageData") ?? ""
        entry = WonderousTimelineEntry(
            date: Date(),
            discoveredCount:discoveredCount,
            title: title,
            subTitle: subTitle.prefix(1).capitalized + subTitle.dropFirst(),
            imageData: imageData
        )
        completion(entry);
    }
    
    // Provide an array of entries for the current time and, optionally, any future times
    func getTimeline(in context: Context, completion: @escaping (Timeline<WonderousTimelineEntry>) -> ()) {
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}





