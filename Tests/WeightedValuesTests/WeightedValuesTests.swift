import XCTest
@testable import WeightedValues

final class WeightedValuesTests: XCTestCase {

    func testOfExampleSet() {
        var north: WeightedSet!, south: WeightedSet!, east: WeightedSet!, west: WeightedSet!, total: WeightedSet! = nil
        measure {
            north = makeTestSet(label: "North", weight: 1.7, prop01: 100, prop02: nil, prop03: 100, prop04: true)
            south = makeTestSet(label: "South", weight: 10, prop01: 88.7, prop02: 97, prop03: 28, prop04: false)
            east = makeTestSet(label: "East", weight: 1.5, prop01: 85, prop02: 78, prop03: 87, prop04: true)
            west = makeTestSet(label: "West", weight: 0.2, prop01: 23, prop02: nil, prop03: 99, prop04: false)
            total = WeightedSet("Total", subValues: north, south, east, west)
        }
        print()
        print("Test Set Results:")
        print(String(repeating: "-", count: 67))
        print(north ?? "None")
        print(south ?? "None")
        print(east ?? "None")
        print(west ?? "None")
        print(String(repeating: "-", count: 67))
        print(total ?? "None")
        print()
        
        XCTAssertEqual(north.points, 100)
        XCTAssertEqual(south.points, 84)
        XCTAssertEqual(east.points, 84)
        XCTAssertEqual(west.points, 41)
        XCTAssertEqual(total.points, 86)
        XCTAssertEqual(Int(total.normalized ?? 0), 85)
    }

    static var allTests = [
        ("testOfExampleSet", testOfExampleSet),
    ]
}
