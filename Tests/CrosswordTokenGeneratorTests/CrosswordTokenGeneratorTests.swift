import XCTest
@testable import CrosswordTokenGenerator

final class CrosswordTokenGeneratorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CrosswordTokenGenerator().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
