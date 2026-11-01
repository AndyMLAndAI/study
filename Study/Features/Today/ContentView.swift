import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var currentActivity: Activity<FocusActivityAttributes>?

    var body: some View {
        VStack(spacing: 24) {
            Text("Study")
                .font(.system(size: 34, weight: .semibold))
                .foregroundStyle(Color(red: 0.114, green: 0.114, blue: 0.122)) // carbon #1D1D1F

            Button(action: startFocus) {
                Text("Start Focus")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Color(red: 0.957, green: 0.973, blue: 0.984)) // #F4F8FB
                    .padding(.horizontal, 24)
                    .frame(height: 56)
                    .background(Color(red: 0.0, green: 0.443, blue: 0.890)) // appleBlue #0071E3
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.961, green: 0.961, blue: 0.969)) // canvas #F5F5F7
    }

    private func startFocus() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }

        for activity in Activity<FocusActivityAttributes>.activities {
            Task {
                await activity.end(nil, dismissalPolicy: .immediate)
            }
        }

        let attributes = FocusActivityAttributes(
            subjectName: "Sample",
            plannedSeconds: 1500
        )
        let initialContentState = FocusActivityAttributes.ContentState(
            endDate: Date().addingTimeInterval(1500),
            isPaused: false,
            remainingSeconds: 1500
        )

        do {
            let activity = try Activity.request(
                attributes: attributes,
                content: .init(state: initialContentState, staleDate: nil),
                pushType: nil
            )
            currentActivity = activity
        } catch {
            // VERIFY-ON-CI: Fallback or error logging
        }
    }
}
