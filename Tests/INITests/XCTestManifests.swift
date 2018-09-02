import XCTest

extension ParseINITests {
    static let __allTests = [
        ("testParseINI", testParseINI),
        ("testParseINIInvalidConfig", testParseINIInvalidConfig),
        ("testParseINILeadingWhitespace", testParseINILeadingWhitespace),
        ("testParseINIMissingField", testParseINIMissingField),
        ("testParseINIMissingProfile", testParseINIMissingProfile),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ParseINITests.__allTests),
    ]
}
#endif
