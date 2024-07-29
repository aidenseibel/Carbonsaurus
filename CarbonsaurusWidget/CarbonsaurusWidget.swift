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
    let user: User = DataModel.getLocalUserFromAppStorage() ?? User(username: "default account", averageDriving: 1, averagePhone: 195, averageAppliances: 1, averageEating: 1800, averageShower: 10);
}

struct CarbonsaurusWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
            HStack {
                ZStack {
                    Image(entry.user.getAvatarImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(100)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
                Spacer()
                VStack {
                    Text("\(Int(entry.user.getDinoPoints() )) Dino Points")
                    Text(entry.user.getDinoMood().rawValue )
                        .multilineTextAlignment(.center)
                        .font(.system(size: 32))
                        .bold()
                    Text("\(Int(entry.user.getCarbonFootprintThisWeek() )) kg of carbon this week")
                }
                Spacer()
            }
            .padding()
    }
}



struct CarbonsaurusWidget: Widget {
    let kind: String = "CarbonsaurusWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CarbonsaurusWidgetEntryView(entry: entry)
                .containerBackground(entry.user.avatar.color.swiftUIColor, for: .widget)
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

extension AvatarColor {
    var swiftUIColor: Color {
        switch self {
        case .lightGreen:
            return Color.green.opacity(0.5)
        case .green:
            return Color.green.opacity(0.3)
        case .blue:
            return Color.blue.opacity(0.3)
        case .orange:
            return Color.orange.opacity(0.3)
        case .pink:
            return Color.pink.opacity(0.3)
        }
    }
}

#Preview(as: .systemMedium) {
    CarbonsaurusWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
}
