import XCTest

extension Assert where SubjectType: OptionalProtocol {
    @discardableResult
    public func notNil(
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> SubjectType.Wrapped {
        guard !subject.isNone else {
            // We use `nil` directly here rather than asserting
            // on `subject` because we can't prove to Swift that
            // `SubjectType` is an `Optional<T>` for some concrete `T`.
            // Which is fair, because a consumer could implement
            // `OptionalProtocol` on their own type and really
            XCTAssertNotNil(nil, message, file: file, line: line)
            throw AssertionError.unexpectedNil
        }
        return subject.unsafelyUnwrapped
    }

    public func isNil(
        _ message: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard subject.isNone else {
            return XCTFail(message, file: file, line: line)
        }
    }
}

/// A minimal wrapper for `Optional<T>` which allows us to work
/// around the fact that we can't extend `Assert` for unconstrained
/// generic types. We instead extend it for any implementor of this
/// protocol, with the assumption that the only implementor is
/// `Optional`. You are not expected to implement this protocol
/// on any of your own types.
public protocol OptionalProtocol {
    associatedtype Wrapped
    var unsafelyUnwrapped: Wrapped { get }

    var isNone: Bool { get }
}

extension Optional: OptionalProtocol {
    public var isNone: Bool { return self == nil }
}
