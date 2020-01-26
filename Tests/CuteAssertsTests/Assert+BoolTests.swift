import XCTest
import CuteAsserts

final class AssertBoolSuccesses: XCTestCase {
    func test_assertTrueIsTrue_passes() {
        Assert(true).isTrue()
    }
    
    func test_assertFalseIsFalse_passes() {
        Assert(false).isFalse()
    }

    func test_assertOptionalTrueIsTrue_passes() {
        let yes: Bool? = true
        try? Assert(yes).isTrue()
    }

    func test_assertOptionalFalseIsFalse_passes() {
        let no: Bool? = false
        try? Assert(no).isFalse()
    }
}

final class AssertBoolFailures: ExpectedFailureTestCase {
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

    func test_assertOptionalIsFalse_nilAndTrue_fail() {
        for input: Bool? in [nil, true] {
            do { try Assert(input).isFalse() }
            catch {}
        }
    }

    func test_assertOptionalIsTrue_nilAndFalse_fail() {
        for input: Bool? in [nil, false] {
            do { try Assert(input).isTrue() }
            catch {}
        }
    }

    func test_assertNilIsFalse_failsWithSensibleErrorMessage() {
        try? Assert(nil).isFalse()
        assertFailure(hadMessage: "nil is not equal to false")
    }

    func test_assertNilIsTrue_failsWithSensibleErrorMessage() {
        try? Assert(nil).isTrue()
        assertFailure(hadMessage: "nil is not equal to true")
    }
}
