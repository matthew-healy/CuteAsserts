import XCTest

public struct Assert<SubjectType> {
    let subject: SubjectType?
    
    public init(_ subject: SubjectType?) {
        self.subject = subject
    }
}
