import WidgetKit
import SwiftUI
import Intents

/// Entry, is passed into the view and defines the data it needs
struct WonderousTimelineEntry : TimelineEntry {
    let date: Date
    let discoveredCount:Int;
    var title:String = "";
    var subTitle:String = "";
    var imageData:String = "";
}

// Widget, defines the display name and description and also declared the main View
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

// Provider,returns various WonderousEntry configs based on current context
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





