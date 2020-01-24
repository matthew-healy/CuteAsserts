import XCTest
import HandsomeAssert

final class AssertIsEqualSuccessTests: XCTestCase {
    func test_assertTrueAndTrueAreEqual_succeeds() {
        Assert(true).isEqual(to: true)
    }
}

final class AssertIsEqualFailureTests: ExpectedFailureTestCase {
    func test_assertTrueAndFalseAreEqual_fails() {
        Assert(true).isEqual(to: false)
    }

    func test_assertFalseAndTrueAreEqual_includesFailureMessage() {
        for message in ["expected", "failure"] {
            Assert(false).isEqual(to: true, message)
            assertFailure(hadMessage: message)
        }
    }
}
