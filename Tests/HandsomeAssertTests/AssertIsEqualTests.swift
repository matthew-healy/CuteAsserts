import XCTest
import HandsomeAssert

final class AssertIsEqualSuccessTests: XCTestCase {
    func test_assertTrueAndTrueAreEqual_succeeds() {
        Assert(true).isEqual(to: true)
    }

    func test_assertAbcAndAbcAreEqual_succeeds() {
        Assert("abc").isEqual(to: "abc")
    }

    func test_customEquatableTypesCanBeEqual() {
        struct CustomType: Equatable { let id: Int }
        Assert(CustomType(id: 1)).isEqual(to: CustomType(id: 1))
    }
}

final class AssertIsEqualFailureTests: ExpectedFailureTestCase {
    func test_assert1And3AreEqual_fails() {
        Assert(1).isEqual(to: 3)
    }

    func test_customEquatableTypesCanBeNonEqual() {
        struct CustomType: Equatable { let id: Int }
        Assert(CustomType(id: 0)).isEqual(to: CustomType(id: -1))
    }

    func test_assertABCAndDEFAreEqual_includesFailureMessage() {
        for message in ["expected", "failure"] {
            Assert("ABC").isEqual(to: "DEF", message)
            assertFailure(hadMessage: message)
        }
    }
}
