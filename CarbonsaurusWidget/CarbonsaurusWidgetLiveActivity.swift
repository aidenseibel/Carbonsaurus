//
//  CarbonsaurusWidgetLiveActivity.swift
//  CarbonsaurusWidget
//
//  Created by Yash Shah on 2/25/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CarbonsaurusWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct CarbonsaurusWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CarbonsaurusWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension CarbonsaurusWidgetAttributes {
    fileprivate static var preview: CarbonsaurusWidgetAttributes {
        CarbonsaurusWidgetAttributes(name: "World")
    }
}

extension CarbonsaurusWidgetAttributes.ContentState {
    fileprivate static var smiley: CarbonsaurusWidgetAttributes.ContentState {
        CarbonsaurusWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: CarbonsaurusWidgetAttributes.ContentState {
         CarbonsaurusWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: CarbonsaurusWidgetAttributes.preview) {
   CarbonsaurusWidgetLiveActivity()
} contentStates: {
    CarbonsaurusWidgetAttributes.ContentState.smiley
    CarbonsaurusWidgetAttributes.ContentState.starEyes
}
