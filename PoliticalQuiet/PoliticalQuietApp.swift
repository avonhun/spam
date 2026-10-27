import SwiftUI

@main
struct PoliticalQuietApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}

struct ContentView: View {
    @State private var sample = ""
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Label("Less political noise", systemImage: "text.bubble.badge.shield")
                        .font(.title2.bold())
                    Text("Filter likely political fundraising and petition spam from unknown senders. All classification happens on your iPhone.")
                }
                Section("Enable the filter") {
                    Text("1. Open Settings → Apps → Messages → Unknown & Spam (on older iOS versions: Settings → Messages).")
                    Text("2. Turn on Filter Unknown Senders, then select Political Quiet under SMS Filtering. Labels may vary by iOS version.")
                    Text("3. Check the Junk folder in Messages occasionally for wanted texts.")
                }
                Section("Try a message") {
                    TextEditor(text: $sample)
                        .frame(minHeight: 110)
                        .accessibilityLabel("Message to check")
                    if !sample.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Label(PoliticalSpamClassifier.isPoliticalSpam(sample)
                              ? "Likely political spam → Junk" : "No political spam match",
                              systemImage: PoliticalSpamClassifier.isPoliticalSpam(sample)
                              ? "tray.and.arrow.down" : "checkmark.circle")
                    }
                }
                Section("What to expect") {
                    Text("This app cannot stop delivery. iOS offers eligible SMS/MMS from unknown senders to the filter; it does not filter iMessage or messages from your contacts. iOS decides which messages are eligible.")
                    Text("Conservative rules look for political context plus a solicitation. Some spam will be missed and some wanted messages may match. Adding a trusted sender to Contacts helps keep their messages out of this filter.")
                    Text("No account, analytics, network service, or message archive. The app cannot inspect your inbox or tell whether you enabled the extension.")
                }
            }
            .navigationTitle("Political Quiet")
        }
    }
}
