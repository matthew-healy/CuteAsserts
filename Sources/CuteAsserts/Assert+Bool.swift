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

extension Assert where SubjectType == Bool? {
    public func isTrue(
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) throws {
        let unwrapped = try notNil(
            "nil is not equal to true",
            file: file, line: line
        )
        Assert<Bool>(unwrapped).isTrue(
            message,
            file: file, line: line
        )
    }

    public func isFalse(
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) throws {
        let unwrapped = try notNil(
            "nil is not equal to false",
            file: file, line: line
        )
        Assert<Bool>(unwrapped).isFalse(
            message,
            file: file, line: line
        )
    }

}
