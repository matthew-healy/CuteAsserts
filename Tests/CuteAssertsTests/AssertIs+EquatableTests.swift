import XCTest
import CuteAsserts

// MARK: Expected successes

final class AssertEquatableSuccesses: XCTestCase {
    func test_assertTrueAndTrueAreEqual_succeeds() {
        Assert(true).equal(to: true)
    }

    func test_assertAbcAndAbcAreEqual_succeeds() {
        Assert("abc").equal(to: "abc")
    }

    func test_customEquatableTypesCanBeEqual() {
        Assert(CustomType(id: 1)).equal(to: CustomType(id: 1))
    }

    func test_assertAbcAndDefAreNotEqual_succeeds() {
        Assert("Abc").notEqual(to: "Def")
    }
}

// MARK: Expected failures

final class AssertEquatableFailures: ExpectedFailureTestCase {
    func test_assert1And3AreEqual_fails() {
        Assert(1).equal(to: 3)
    }

    func test_customEquatableTypesCanBeNonEqual() {
        Assert(CustomType(id: 0)).equal(to: CustomType(id: -1))
    }

    func test_assertABCAndDEFAreEqual_includesFailureMessage() {
        for message in ["expected", "failure"] {
            Assert("ABC").equal(to: "DEF", message)
            assertFailure(hadMessage: message)
        }
    }

    func test_assertTypeWithAsymmetricEqualityIsEqual_failsWithNotSymmetricalError() {
        Assert(Asymmetric(id: 1)).equal(to: Asymmetric(id: -1))
        assertFailure(
            hadMessage: "Equality is not symmetrical for type Asymmetric."
        )
    }

    func test_assertSameCustomTypeIsNotEqual_fails() {
        Assert(CustomType(id: 0)).notEqual(to: CustomType(id: 0))
    }

    func test_assertFalseAndFalseAreNotEqual_includesFailureMessage() {
        for message in ["wat", "wai"] {
            Assert(false).notEqual(to: false, message)
            assertFailure(hadMessage: message)
        }
    }

    func test_assertTypeWithAsymmetricEqualityIsNotEqual_failsWithNotSymmetricalError() {
        Assert(Asymmetric(id: 0)).notEqual(to: Asymmetric(id: 1))
        assertFailure(
            hadMessage: "Inequality is not symmetrical for type Asymmetric."
        )
    }
}

// MARK: Private test data types

private struct CustomType: Equatable {
    let id: Int
}

private struct Asymmetric: Equatable {
    let id: Int

    static func ==(lhs: Asymmetric, rhs: Asymmetric) -> Bool {
        return lhs.id > rhs.id
    }
}
