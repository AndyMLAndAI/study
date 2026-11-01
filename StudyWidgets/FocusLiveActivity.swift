import ActivityKit
import WidgetKit
import SwiftUI

struct FocusLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FocusActivityAttributes.self) { context in
            // Lock Screen banner
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(context.attributes.subjectName)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.secondary)

                    Text("Focus")
                        .font(.system(size: 17, weight: .semibold))
                }

                Spacer()

                if context.state.isPaused {
                    Text("Paused")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .monospacedDigit()
                } else {
                    Text(timerInterval: Date()...context.state.endDate, countsDown: true)
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .monospacedDigit()
                }
            }
            .padding(16)
            .activityBackgroundTint(Color(red: 0.114, green: 0.114, blue: 0.122))
            .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.attributes.subjectName)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.leading, 8)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if context.state.isPaused {
                        Text("Paused")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .monospacedDigit()
                            .padding(.trailing, 8)
                    } else {
                        Text(timerInterval: Date()...context.state.endDate, countsDown: true)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .monospacedDigit()
                            .padding(.trailing, 8)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Text("Focus Session")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 8)
                }
            } compactLeading: {
                Circle()
                    .fill(Color(red: 0.0, green: 0.443, blue: 0.890))
                    .frame(width: 10, height: 10)
            } compactTrailing: {
                if context.state.isPaused {
                    Text("||")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                } else {
                    Text(timerInterval: Date()...context.state.endDate, countsDown: true)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .monospacedDigit()
                        .frame(width: 44)
                }
            } minimal: {
                Circle()
                    .fill(Color(red: 0.0, green: 0.443, blue: 0.890))
                    .frame(width: 10, height: 10)
            }
            .widgetURL(URL(string: "study://focus"))
        }
    }
}
