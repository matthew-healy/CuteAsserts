import XCTest

extension Assert {
    @discardableResult
    public func notNil(
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> SubjectType {
        guard let subject = subject else {
            XCTAssertNotNil(
                self.subject, message,
                file: file, line: line
            )
            throw AssertionError.unexpectedNil
        }
        return subject
    }
}
