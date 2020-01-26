import XCTest

extension Assert where SubjectType == Bool {
    public func isTrue(
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertTrue(
            subject,
            message,
            file: file, line: line
        )
    }

    public func isFalse(
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertFalse(
            subject,
            message,
            file: file, line: line
        )
    }
}
