import XCTest

extension ParseINITests {
    static let allTests = [
        ("testParseINI", testParseINI),
        ("testParseINIInvalidConfig", testParseINIInvalidConfig),
        ("testParseINILeadingWhitespace", testParseINILeadingWhitespace),
        ("testParseINIMissingField", testParseINIMissingField),
        ("testParseINIMissingProfile", testParseINIMissingProfile),
        ("testParseINIWhiteSpaceAroundEquals", testParseINIWhiteSpaceAroundEquals)
    ]
}

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ParseINITests.allTests)
    ]
}
#endif
