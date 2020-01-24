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
        struct CustomType: Equatable { let id: Int }
        Assert(CustomType(id: 0)).isEqual(to: CustomType(id: -1))
    }

    func test_assertABCAndDEFAreEqual_includesFailureMessage() {
        for message in ["expected", "failure"] {
            Assert("ABC").isEqual(to: "DEF", message)
            assertFailure(hadMessage: message)
        }
    }

    func test_assertTypeWithAsymmetricEqualityIsEqual_fails() {
        Assert(Asymmetric(id: 1)).isEqual(to: Asymmetric(id: -1))
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

    func test_assertTypeWithAsymmetricEqualityNotEqual_fails() {
        Assert(Asymmetric(id: 5)).isNotEqual(to: Asymmetric(id: 5))
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
