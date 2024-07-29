import WidgetKit
import SwiftUI

// Ensure SimpleEntry conforms to TimelineEntry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let viewModel: ViewModel
}

// Ensure Provider conforms to AppIntentTimelineProvider
struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), viewModel: ViewModel())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, viewModel: ViewModel())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline with entries for the next 24 hours
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!

        let entry = SimpleEntry(date: entryDate, configuration: configuration, viewModel: ViewModel())
        entries.append(entry)

        // Return the timeline with a policy to refresh daily
        return Timeline(entries: entries, policy: .after(entryDate))
    }
}

// Define the view for the widget
struct CarbonsaurusWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(viewModel: entry.viewModel)
        case .systemMedium:
            MediumWidgetView(viewModel: entry.viewModel)
        default:
            MediumWidgetView(viewModel: entry.viewModel)
        }
    }
}

// Define the widget configuration
struct CarbonsaurusWidget: Widget {
    let kind: String = "CarbonsaurusWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CarbonsaurusWidgetEntryView(entry: entry)
                .containerBackground(entry.viewModel.hasOnboarded && entry.viewModel.hasLoggedToday ? entry.viewModel.localUser.avatar.color.swiftUIColor : .white, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// Extensions for ConfigurationAppIntent and AvatarColor
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

// Preview configuration
#Preview(as: .systemMedium) {
    CarbonsaurusWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, viewModel: ViewModel())
}
