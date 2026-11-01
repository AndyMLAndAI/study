import ActivityKit
import Foundation

public struct FocusActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        public var endDate: Date
        public var isPaused: Bool
        public var remainingSeconds: Int

        public init(endDate: Date, isPaused: Bool, remainingSeconds: Int) {
            self.endDate = endDate
            self.isPaused = isPaused
            self.remainingSeconds = remainingSeconds
        }
    }

    public var subjectName: String
    public var plannedSeconds: Int

    public init(subjectName: String, plannedSeconds: Int) {
        self.subjectName = subjectName
        self.plannedSeconds = plannedSeconds
    }
}
