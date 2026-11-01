import XCTest

final class ScreenshotUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testCaptureMainScreen() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--screenshot-mode"]
        app.launch()

        // Wait up to 2.0s for the screen to settle
        let title = app.staticTexts["Study"]
        XCTAssertTrue(title.waitForExistence(timeout: 2.0))

        // Give UI 0.5s to settle rendering
        Thread.sleep(forTimeInterval: 0.5)

        // Capture screenshot and attach
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways
        attachment.name = "01-main"
        add(attachment)
    }

    func testCaptureLiveActivity() throws {
        // VERIFY-ON-CI: Attempt to start Live Activity and capture
        let app = XCUIApplication()
        app.launchArguments = ["--screenshot-mode"]
        app.launch()

        let focusButton = app.buttons["Start Focus"]
        if focusButton.waitForExistence(timeout: 2.0) {
            focusButton.tap()
            Thread.sleep(forTimeInterval: 1.0)

            // Switch to home screen to expose Dynamic Island and Lock Screen state
            XCUIDevice.shared.press(.home)
            Thread.sleep(forTimeInterval: 1.0)

            let screenshot = XCUIScreen.main.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.lifetime = .keepAlways
            attachment.name = "02-live-activity"
            add(attachment)
        }
    }
}
