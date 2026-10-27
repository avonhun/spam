# Political Quiet

An offline iPhone SMS/MMS filter for likely political solicitations. SwiftUI app + IdentityLookup message-filter extension, iOS 16+.

## Build on macOS

1. Install Xcode and its command line tools, and XcodeGen (`brew install xcodegen`).
2. In this checkout, run `xcodegen generate` and open `PoliticalQuiet.xcodeproj`.
3. Set unique bundle identifiers and your signing team on both app and extension targets. Keep the extension identifier prefixed by the app identifier.
4. Build the PoliticalQuiet scheme and install on a physical iPhone. Follow the setup instructions in the app to enable SMS filtering.
5. Run tests with `xcodebuild test -scheme PoliticalQuiet -destination 'platform=iOS Simulator,name=iPhone 16'` (choose an installed simulator name).

The classifier tests cover political solicitations, unrelated messages, word boundaries, and a known false positive. A Mac with Xcode is required to compile and run these tests; Linux cannot build the iOS app.

## Device validation

Enable the extension in Messages settings. Send an SMS from an unknown number containing “Our Senate campaign needs you. Chip in $5 today!” and verify it goes to Junk. Send an unrelated verification-code message and verify it is not classified as junk by this extension. Confirm a contact’s messages and iMessages remain outside the extension’s scope. Inspect Junk periodically. Simulator previews and the in-app classifier demo do not prove real SMS routing works.

## Privacy and limits

No message contents are stored or transmitted. No backend, API credentials, app groups, or network entitlement is needed. The extension returns Junk only when both political context and solicitation language match. Otherwise it returns no opinion to iOS. Rules are English-only and imperfect; the app does not promise to catch all political texts. It cannot stop delivery, access inbox history, inspect its activation status, or filter iMessage. Add trusted senders to Contacts as an allowlist; this version has no separate custom allowlist.

Before public release, complete device testing, signing, App Store privacy disclosures, accessibility review, and review Apple's current message-filter extension requirements.
