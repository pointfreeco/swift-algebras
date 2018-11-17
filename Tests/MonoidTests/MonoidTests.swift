import XCTest
@testable import Monoid

final class MonoidTests: XCTestCase {
  func testExample() {

    XCTAssertEqual("Hello World", Monoid.array.concat(["Hello", " ", "World"]))

    
  }

  static var allTests = [
    ("testExample", testExample),
    ]
}


func test<R: RangeReplaceableCollection>(_ xs: R) {}
