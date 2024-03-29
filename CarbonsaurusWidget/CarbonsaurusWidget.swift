//
//  CarbonsaurusWidget.swift
//  CarbonsaurusWidget
//
//  Created by Yash Shah on 2/25/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct CarbonsaurusWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack {
            ZStack {
                Image("orange_dino_neutral")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(100)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            Spacer()
            VStack {
                Text("4000 dino points")
                Text("neutral")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 32))
                    .bold()
                Text("12 kg of carbon today")

            }
            Spacer()
        }

    }
}

struct CarbonsaurusWidget: Widget {
    let kind: String = "CarbonsaurusWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CarbonsaurusWidgetEntryView(entry: entry)
                .containerBackground(.orange.opacity(0.3), for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemMedium) {
    CarbonsaurusWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
}
