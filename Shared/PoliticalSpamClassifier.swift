import Foundation

/// Conservative, offline rules. No message content is stored or transmitted.
enum PoliticalSpamClassifier {
    static func isPoliticalSpam(_ message: String) -> Bool {
        let text = message.lowercased()
        let political = [
            "campaign", "candidate", "election", "democrat", "democrats",
            "republican", "republicans", "congress", "senate", "senator",
            "governor", "president", "political", "ballot", "gop"
        ]
        let solicitation = [
            "donate", "donation", "contribute", "contribution", "chip in",
            "fundraising", "fundraiser", "matching", "match your", "rush $",
            "take our poll", "take this poll", "sign our petition"
        ]
        // Fundraising platforms are strong indicators only alongside a request.
        let platforms = ["actblue.com", "winred.com", "secure.actblue", "secure.winred"]
        let context = political.contains { containsPhrase($0, in: text) }
            || platforms.contains { containsPhrase($0, in: text) }
        return context && solicitation.contains { containsPhrase($0, in: text) }
    }

    private static func containsPhrase(_ phrase: String, in text: String) -> Bool {
        let escaped = NSRegularExpression.escapedPattern(for: phrase)
        return text.range(of: "(?<![\\p{L}\\p{N}])" + escaped + "(?![\\p{L}\\p{N}])",
                          options: .regularExpression) != nil
    }
}
