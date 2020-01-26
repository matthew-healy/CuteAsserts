import XCTest
import CuteAsserts

final class AssertOptionSuccesses: XCTestCase {
    func test_assertYESNotNil_passes() {
        let yes: String? = "YES"
        try! Assert(yes).notNil()
    }

    func test_assertTrueNotNil_returnsNonOptionalTrue() {
        let maybeTrue: Bool? = true
        let returned = try! Assert(maybeTrue).notNil()
        XCTAssertTrue(returned)
    }

    func test_assertNilIsNil_passes() {
        let no: String? = nil
        Assert(no).isNil()
    }
}

final class AssertOptionFailures: ExpectedFailureTestCase {
    func test_assertNilNotNil_fails() {
        let nothing: Int? = nil
        do { try Assert(nothing).notNil() }
        catch {}
    }

    func test_assertNilNotNil_failsByThrowing() throws {
        let nothing: Float? = nil
        try Assert(nothing).notNil()
    }

    func test_assertNilNotNil_includesFailureMessage() {
        for message in ["unfalse", "not true"] {
            let nothing: Int? = nil
            do { try Assert(nothing).notNil(message) }
            // Throwing into the test scope will prevent the
            // checks from running so catch & ignore the error.
            catch {}
            assertFailure(hadMessage: message)
        }
    }

    func test_assertOneIsNil_fails() {
        let one: String? = "one"
        Assert(one).isNil()
    }

    func test_assert9IsNil_includesFailureMessage() {
        for message in ["it's 9", "that's not nil"] {
            let nine: Int? = 9
            Assert(nine).isNil(message)
            assertFailure(hadMessage: message)
        }
    }
}
