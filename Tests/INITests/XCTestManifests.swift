import XCTest

extension ParseINITests {
    static let __allTests = [XCTestCase]()
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ParseINITests.__allTests),
    ]
}
#endif
