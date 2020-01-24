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
        guard isSymmetric(==, values: (subject, other)) else {
            return XCTFail(
                "Equality is not symmetrical for type \(SubjectType.self)."
            )
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
        guard isSymmetric(!=, values: (subject, other)) else {
            return XCTFail(
                "Inequality is not symmetrical for type \(SubjectType.self)."
            )
        }
        XCTAssertNotEqual(
            subject, other,
            message,
            file: file, line: line
        )
    }

    private func isSymmetric(
        _ op: (SubjectType, SubjectType) -> Bool,
        values: (SubjectType, SubjectType)
    ) -> Bool {
        op(values.0, values.1) == op(values.1, values.0)
    }
}
