import XCTest

public struct Assert<SubjectType> {
    private let subject: SubjectType
    
    public init(_ subject: SubjectType) {
        self.subject = subject
    }
}

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

extension Assert where SubjectType: Equatable {
    public func isEqual(
        to other: SubjectType,
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
