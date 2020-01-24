import XCTest

public struct Assert {
    private let subject: Bool
    
    public init(_ subject: Bool) {
        self.subject = subject
    }
    
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

    public func isEqual(
        to other: Bool,
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            subject, other,
            message,
            file: file, line: line
        )
    }
}
