import Foundation
@testable import WeightedValues

func makeTestSet(label: String, weight: Double, prop01: Double?, prop02: Double?, prop03: Double?, prop04: Bool) -> WeightedSet {
    let color = WeightedValue("\(label) Color", value: prop01, weight: 4)
    let color2 = WeightedValue("\(label) Color 2", value: prop02, weight: 4)
    let size = WeightedValue("\(label) Size", value: prop03, weight: 1.2)
    let matches = WeightedFlag("\(label) Matches", is: prop04, weight: 0.15, isBonus: true)
    let testSet = WeightedSet(label, weight: weight, subValues: color, color2, size, matches)
    return testSet
}
