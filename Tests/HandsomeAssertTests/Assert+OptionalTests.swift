import XCTest
import HandsomeAssert

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
        let nothing: Int? = nil
        do { try Assert(nothing).notNil("unfalse") }
        catch {
            // Catch & ignore the error so it doesn't throw
            // into the test scope.
        }
        assertFailure(hadMessage: "unfalse")
    }
}
