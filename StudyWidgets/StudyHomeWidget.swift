import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct StudyWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let timeline = Timeline(entries: [SimpleEntry(date: Date())], policy: .never)
        completion(timeline)
    }
}

struct StudyHomeWidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Study")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color(red: 0.114, green: 0.114, blue: 0.122))

            Text("Ready when you are.")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color(red: 0.439, green: 0.439, blue: 0.439))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .widgetURL(URL(string: "study://focus"))
    }
}

struct StudyHomeWidget: Widget {
    let kind: String = "StudyHomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StudyWidgetProvider()) { entry in
            StudyHomeWidgetEntryView(entry: entry)
                .containerBackground(Color(red: 0.961, green: 0.961, blue: 0.969), for: .widget)
        }
        .configurationDisplayName("Study")
        .description("Quick launcher for your focus sessions.")
        .supportedFamilies([.systemSmall])
    }
}
