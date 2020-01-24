import XCTest
import HandsomeAssert

// MARK: Expected successes

final class AssertEqualitySuccessTests: XCTestCase {
    func test_assertTrueAndTrueAreEqual_succeeds() {
        Assert(true).isEqual(to: true)
    }

    func test_assertAbcAndAbcAreEqual_succeeds() {
        Assert("abc").isEqual(to: "abc")
    }

    func test_customEquatableTypesCanBeEqual() {
        Assert(CustomType(id: 1)).isEqual(to: CustomType(id: 1))
    }

    func test_assertAbcAndDefAreNotEqual_succeeds() {
        Assert("Abc").isNotEqual(to: "Def")
    }
}

// MARK: Expected failures

final class AssertEqualityFailureTests: ExpectedFailureTestCase {
    func test_assert1And3AreEqual_fails() {
        Assert(1).isEqual(to: 3)
    }

    func test_customEquatableTypesCanBeNonEqual() {
        Assert(CustomType(id: 0)).isEqual(to: CustomType(id: -1))
    }

    func test_assertABCAndDEFAreEqual_includesFailureMessage() {
        for message in ["expected", "failure"] {
            Assert("ABC").isEqual(to: "DEF", message)
            assertFailure(hadMessage: message)
        }
    }

    func test_assertTypeWithAsymmetricEqualityIsEqual_failsWithNotSymmetricalError() {
        Assert(Asymmetric(id: 1)).isEqual(to: Asymmetric(id: -1))
        assertFailure(
            hadMessage: "Equality is not symmetrical for type Asymmetric."
        )
    }

    func test_assertSameCustomTypeIsNotEqual_fails() {
        Assert(CustomType(id: 0)).isNotEqual(to: CustomType(id: 0))
    }

    func test_assertFalseAndFalseAreNotEqual_includesFailureMessage() {
        for message in ["wat", "wai"] {
            Assert(false).isNotEqual(to: false, message)
            assertFailure(hadMessage: message)
        }
    }

    func test_assertTypeWithAsymmetricEqualityIsNotEqual_failsWithNotSymmetricalError() {
        Assert(Asymmetric(id: 0)).isNotEqual(to: Asymmetric(id: 1))
        assertFailure(
            hadMessage: "Inequality is not symmetrical for type Asymmetric."
        )
    }
}

// MARK: Test data types

private struct CustomType: Equatable {
    let id: Int
}

private struct Asymmetric: Equatable {
    let id: Int

    static func ==(lhs: Asymmetric, rhs: Asymmetric) -> Bool {
        return lhs.id > rhs.id
    }
}
