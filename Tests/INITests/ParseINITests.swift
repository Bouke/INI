import XCTest
@testable import INI

final class ParseINITests: XCTestCase {
    func testParseINI() {
        // Given
        let profileName = "dev"
        let field1 = "test-field"
        let value1 = "somevalue"
        let field2 = "another-field"
        let value2 = "val"
        // Create config
        let string = """
        [\(profileName)]
        \(field1)=\(value1)
        \(field2)=\(value2)
        """
        do {
            // When
            let config = try parseINI(string: string)
            // Then
            XCTAssertNotNil(config[profileName])
            guard let settings = config[profileName] else {
                XCTFail("Unexpected nil")
                return
            }
            XCTAssertEqual(value1, settings[field1])
            XCTAssertEqual(value2, settings[field2])
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testParseINILeadingWhitespace() {
        // Given
        let profileName = "dev"
        let field1 = "test-field"
        let value1 = "somevalue"
        let field2 = "another-field"
        let value2 = "val"
        // Create config with whitespace at the top
        let string = """


        [\(profileName)]
        \(field1)=\(value1)
        \(field2)=\(value2)
        """
        do {
            // When
            let config = try parseINI(string: string)
            // Then
            XCTAssertNotNil(config[profileName])
            guard let settings = config[profileName] else {
                XCTFail("Unexpected nil")
                return
            }
            XCTAssertEqual(value1, settings[field1])
            XCTAssertEqual(value2, settings[field2])
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testParseINIMissingProfile() {
        // Given
        let string = """
        [dev]
        test-field=somevalue
        """
        do {
            // When
            let config = try parseINI(string: string)
            // Then
            XCTAssertNil(config["unknown-profile"])
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testParseINIMissingField() {
        // Given
        let profileName = "dev"
        let string = """
        [\(profileName)]
        test-field=somevalue
        """
        do {
            // When
            let config = try parseINI(string: string)
            // Then
            XCTAssertNotNil(config[profileName])
            guard let settings = config[profileName] else {
                XCTFail("Unexpected nil")
                return
            }
            XCTAssertNil(settings["some-unknown-field"])
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testParseINIInvalidConfig() {
        // Given
        let string = "some random string..."
        do {
            // When
            let _ = try parseINI(string: string)
            XCTFail("Unexpected success")
        } catch _ as ParseError {
            // Success
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
