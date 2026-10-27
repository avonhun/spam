import XCTest

final class PoliticalSpamClassifierTests: XCTestCase {
    func testPoliticalSolicitations() {
        for message in [
            "Our Senate campaign needs you. Chip in $5 today!",
            "DONATE to support this Republican candidate.",
            "Contribute here: https://secure.actblue.com/donate/example",
            "Election update: sign our petition."
        ] {
            XCTAssertTrue(PoliticalSpamClassifier.isPoliticalSpam(message), message)
        }
    }

    func testWantedAndUnrelatedMessages() {
        for message in [
            "", "Your verification code is 123456",
            "The election is Tuesday. Polls open at 7.",
            "Please donate to our food bank.",
            "Can you contribute to dinner?",
            "The campaign meeting is at noon.",
            "Donate to our congressionally themed bake sale."
        ] {
            XCTAssertFalse(PoliticalSpamClassifier.isPoliticalSpam(message), message)
        }
    }

    func testKnownFalsePositiveIsVisible() {
        // Context-free rules cannot distinguish every nonpolitical use of these words.
        XCTAssertTrue(PoliticalSpamClassifier.isPoliticalSpam(
            "Donate to the campaign for our local food bank."))
    }
}
