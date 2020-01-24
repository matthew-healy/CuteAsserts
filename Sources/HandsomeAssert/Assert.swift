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
        let subjectOnLhs = subject == other
        let subjectOnRhs = other == subject
        guard subjectOnLhs == subjectOnRhs else {
            return XCTFail("Equality is not symmetrical for type \(SubjectType.self).")
        }
        XCTAssertEqual(
            subject, other,
            message,
            file: file, line: line
        )
    }

    public func isNotEqual(
        to other: SubjectType,
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let subjectOnLhs = subject != other
        let subjectOnRhs = other != subject
        guard subjectOnLhs == subjectOnRhs else {
            return XCTFail("Inequality is not symmetrical for type \(SubjectType.self).")
        }
        XCTAssertNotEqual(
            subject, other,
            message,
            file: file, line: line
        )
    }
}
