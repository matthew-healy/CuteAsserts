import XCTest
@testable import HandsomeAssert

final class HandsomeAssertTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HandsomeAssert().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
