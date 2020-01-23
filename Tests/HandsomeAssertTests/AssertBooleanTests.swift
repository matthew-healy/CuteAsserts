import XCTest
import HandsomeAssert

final class AssertBooleanSuccessTests: XCTestCase {
    func test_assertTrueIsTrue_passes() {
        Assert(true).isTrue()
    }
    
    func test_assertFalseIsFalse_passes() {
        Assert(false).isFalse()
    }
}

final class AssertBooleanFailureTests: ExpectedFailureTestCase {
    func test_assertFalseIsTrue_fails() {
        Assert(false).isTrue()
    }
    
    func test_assertFalseIsTrue_includesFailureMessage() {
        for message in ["message", "bad fail"] {
            Assert(false).isTrue(message)
            assertFailure(hadMessage: message)
        }
    }
    
    func test_assertTrueIsFalse_fails() {
        Assert(true).isFalse()
    }
    
    func test_assertTrueIsFalse_includesFailureMessage() {
        for message in ["1", "222"] {
            Assert(true).isFalse(message)
            assertFailure(hadMessage: message)
        }
    }
    
    private func assertFailure(
        hadMessage message: String,
        file: StaticString = #file, line: UInt = #line
    ) {
        XCTAssertTrue(
            lastFailure.message.hasSuffix(message),
            """
            __force
            Expected "\(message)" to suffix "\(lastFailure.message)"
            """
        )
    }
}
