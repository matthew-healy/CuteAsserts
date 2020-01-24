import XCTest
import HandsomeAssert

final class AssertEqualitySuccessTests: XCTestCase {
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

    func test_assertAbcAndDefAreNotEqual_succeeds() {
        Assert("Abc").isNotEqual(to: "Def")
    }
}

final class AssertEqualityFailureTests: ExpectedFailureTestCase {
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

    func test_assertSameCustomTypeIsNotEqual_fails() {
        struct CustomType: Equatable { let id: Int }
        Assert(CustomType(id: 0)).isNotEqual(to: CustomType(id: 0))
    }

    func test_assertFalseAndFalseAreNotEqual_includesFailureMessage() {
        for message in ["wat", "wai"] {
            Assert(false).isNotEqual(to: false, message)
            assertFailure(hadMessage: message)
        }
    }
}
