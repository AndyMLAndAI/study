import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var currentActivity: Activity<FocusActivityAttributes>?

    var body: some View {
        VStack(spacing: 24) {
            Text("Study")
                .font(.system(.largeTitle, weight: .semibold))
                .foregroundStyle(Color.appCarbon)

            Button(action: startFocus) {
                Text("Start Focus")
                    .font(.system(.body, weight: .semibold))
                    .foregroundStyle(Color.appWash)
                    .padding(.horizontal, 24)
                    .frame(minHeight: 44, idealHeight: 56)
                    .background(Color.appleBlue)
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appCanvas)
        .onAppear {
            ScreenshotMode.configureIfActive()
        }
    }

    private func startFocus() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }

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
            _ = try Activity.request(
                attributes: attributes,
                content: .init(state: initialContentState, staleDate: nil),
                pushType: nil
            )
        } catch {
            // VERIFY-ON-CI: Activity request fallback
        }
    }
}
