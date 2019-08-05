import Foundation

/**
 A weighted numerical value.
 
 # Example
 ```
 let speed = WeightedValue("Speed", value: 89.9, weight: 2.4, isBonus: false)
 ```
 
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
public struct WeightedValue: Weighted, Hashable, Comparable {
    
    public var label: String = ""
    public var value: Double? = nil
    public var weight: Double = baseWeight
    public var isBonus: Bool = false
    
    /// Initializer for weighted values
    public init(_ label: String, value: Double?, weight: Double = defaultWeight, isBonus: Bool = false) {
        self.label = label
        self.weight = limitToRange(keep: weight, within: minWeight...maxWeight)
        self.isBonus = isBonus
        if let value = value {
            self.value = limitToRange(keep: value, within: minValue...maxValue)
        } else {
            self.value = nil
        }
    }
    
    /// For adding to other instances
    public static func + (lhs: WeightedValue, rhs: WeightedValue) -> WeightedValue {
        let lhsWeighted = (lhs.value ?? 0) * lhs.weight
        let lhsWeightedTotal = maxValue * lhs.weight
        let rhsWeighted = (rhs.value ?? 0) * rhs.weight
        let rhsWeightedTotal = maxValue * rhs.weight
        let weightedBase = lhsWeightedTotal + rhsWeightedTotal > 0 ? lhsWeightedTotal + rhsWeightedTotal : 1
        let combinedValue = (lhsWeighted + rhsWeighted) / weightedBase
        let isBonus = lhsWeightedTotal + rhsWeightedTotal <= 0
        return WeightedValue("\(lhs.label) + \(rhs.label)", value: combinedValue, weight: 1, isBonus: isBonus)
    }
    
    /// Creates an empty weighted value.
    public static var empty: WeightedValue { return WeightedValue("", value: 0) }
    
}
