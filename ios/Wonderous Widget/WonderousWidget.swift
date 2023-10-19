//
//  CounterWidget.swift
//  CounterWidget
//
//  Created by Shawn on 2023-09-11.
//

import WidgetKit
import SwiftUI
import Intents

var netImgData: Data? = nil


// Widget, defines the display name and description, and also wraps the View
struct WonderousWidget: Widget {
    let kind: String = "WonderousWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WonderousWidgetView(entry: entry)
        }
        .configurationDisplayName("Wonderous Widget")
        .description("Track your collected artifacts!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// Provider,returns various WonderousEntry configs based on current context
struct Provider: TimelineProvider {
    // Provide an entry for a placeholder version of the widget
    func placeholder(in context: Context) -> WonderousEntry {
        WonderousEntry(date: Date(), count: 0, displaySize: context.displaySize, imageData: netImgData)
    }
    
    // Provide an entry for the current time and state of the widget
    func getSnapshot(in context: Context, completion: @escaping (WonderousEntry) -> ()) {
        let entry:WonderousEntry
        if(context.isPreview){
            //            entry = placeholder(in: context)
            entry = WonderousEntry(date: Date(), count: 0, displaySize: context.displaySize, imageData: netImgData)
        } else {
            let userDefaults = UserDefaults(suiteName: "group.com.gskinner.homewidget")
            let count = userDefaults?.integer(forKey: "counter") ?? 0;
            entry = WonderousEntry(date: Date(), count: count, displaySize: context.displaySize, imageData: netImgData)
        }
        completion(entry);
    }
    
    // Provide an array of entries for the current time and, optionally, any future times
    func getTimeline(in context: Context, completion: @escaping (Timeline<WonderousEntry>) -> ()) {
        // Load a remote image so it can be shown later
        netImgData = try? Data(
            contentsOf: URL(string: "https://www.wonderous.info/unsplash/-e0u9SAFeP4-32.jpg")!
        )
        
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}


/// Entry, is passed into the view and defines the data it needs
struct WonderousEntry : TimelineEntry {
    let date: Date
    let count:Int;
    let displaySize: CGSize
    let imageData: Data?
}





