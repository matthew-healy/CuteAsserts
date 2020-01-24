import XCTest

class ExpectedFailureTestCase: XCTestCase {
    public override var testRunClass: AnyClass? {
        return ExpectedFailureTestRun.self
        
    }
    private var failureTestRun: ExpectedFailureTestRun {
        return testRun as! ExpectedFailureTestRun
    }
    
    private var lastFailure: Failure {
        return failureTestRun.lastFailure!
    }

    func assertFailure(
        hadMessage message: String,
        file: StaticString = #file, line: UInt = #line
    ) {
        XCTAssertTrue(
            lastFailure.message.hasSuffix(message),
            """
            __force
            Expected "\(message)" to suffix "\(lastFailure.message)"
            """,
            file: file, line: line
        )
    }
}

final class ExpectedFailureTestRun: XCTestCaseRun {
    private (set) var lastFailure: Failure?
    
    override func recordFailure(
        withDescription description: String,
        inFile filePath: String?,
        atLine lineNumber: Int,
        expected: Bool
    ) {
        let message = description.split(separator: "\n")
        let forced = message.first?.contains("__force") ?? false
        guard !forced else {
            return super.recordFailure(
                withDescription: message.count > 1
                    ? "Forced failure: \(message[1])"
                    : "Forced failure."
                ,
                inFile: filePath,
                atLine: lineNumber,
                expected: expected
            )
        }
        let failure = Failure(
            message: description,
            file: filePath,
            line: lineNumber,
            expected: expected
        )
        lastFailure = failure
    }
    
    override func stop() {
        defer {
            resetState()
            super.stop()
        }
        guard let _ = lastFailure else {
            return recordPassingTestFailure()
        }
    }
    
    private func resetState() {
        lastFailure = nil
    }
    
    private func recordPassingTestFailure() {
        recordFailure(description: "Expected test to fail but it passed.")
    }
    
    private func recordFailure(description: String) {
        super.recordFailure(withDescription: description, inFile: nil, atLine: 0, expected: true)
    }
}

struct Failure {
    let message: String
    let file: String?
    let line: Int
    let expected: Bool
}
