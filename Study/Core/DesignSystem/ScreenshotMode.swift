import Foundation
import UIKit

/// Supports automated screenshot generation during CI and UI testing.
/// Completely inert in normal application execution.
public struct ScreenshotMode {
    public static var isActive: Bool {
        CommandLine.arguments.contains("--screenshot-mode")
    }

    public static func configureIfActive() {
        guard isActive else { return }
        // Disable UI animations for deterministic screenshots
        UIView.setAnimationsEnabled(false)
    }
}
