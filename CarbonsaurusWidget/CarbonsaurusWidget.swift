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
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), viewModel: ViewModel())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, viewModel: ViewModel())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, viewModel: ViewModel())
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let viewModel: ViewModel
}

struct CarbonsaurusWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack {
            ZStack {
                if entry.viewModel.localUser.avatar.background == AvatarBackground.no_background{
                    Circle()
                        .foregroundColor(.white)
                }
                else{
                    Image(entry.viewModel.localUser.avatar.background.rawValue)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .cornerRadius(UIScreen.main.bounds.width * 0.35)
                }
                Image(entry.viewModel.localUser.getAvatarImage())
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(50)
                    .clipped()
            } .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            Spacer()
            VStack {
                Text("\(Int(entry.viewModel.localUser.getDinoPoints() )) Dino Points")
                Text(entry.viewModel.localUser.getDinoMood().rawValue )
                    .multilineTextAlignment(.center)
                    .font(.system(size: 32))
                    .bold()
                Text("\(Int(entry.viewModel.localUser.getCarbonFootprintThisWeek() )) kg of carbon this week")
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
                .containerBackground(entry.viewModel.localUser.avatar.color.swiftUIColor, for: .widget)
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
    SimpleEntry(date: .now, configuration: .smiley, viewModel: ViewModel())
}
