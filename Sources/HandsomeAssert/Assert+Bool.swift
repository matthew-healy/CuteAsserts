import XCTest

extension Assert where SubjectType == Bool {
    public func isTrue(
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard let subject = subject else {
            // TODO: Add a better message
            return XCTFail()
        }
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
        guard let subject = subject else {
            // TODO: Add a better message
            return XCTFail()
        }
        XCTAssertFalse(
            subject,
            message,
            file: file, line: line
        )
    }
}
