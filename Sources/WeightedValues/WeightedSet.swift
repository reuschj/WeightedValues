import Foundation

/**
 A weighted set of numerical weighted values, weighted flags and/or other weighted sets.
 
 # Example
 ```
 let car = WeightedSet("Car", weight: 1.4, subValues: speed, comfort, style, affordability)
 ```
 
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
public struct WeightedSet: Weighted, Hashable, Comparable {

    public var label: String = ""

    /// A value can contain nested Weighted instances
    public var subValues: [String: Weighted]

    private var selfValue: Double? = nil
    public var value: Double? {
        get {
            var weightedSum: Double = 0
            var weightedMaxSum: Double = 0
            // Add all nested values
            let _ = subValues.map {
                
                let subItem = $0.value
                let subValue = subItem.value
                let knownValue = subValue ?? 0
                let subWeight = subItem.weight
                let subIsBonus = subItem.isBonus
                
                weightedSum += knownValue * subWeight
                if !subIsBonus && subValue != nil {
                    weightedMaxSum += maxValue * subWeight
                }
            }
            let weightedSubValue = (weightedSum / weightedMaxSum) * maxValue
            guard let selfValue = selfValue else { return limitToRange(keep: weightedSubValue, within: minValue...maxValue) }
            guard weightedSubValue > 0 && subValues.count > 0 else { return selfValue }
            let finalValue = (weightedSubValue + selfValue) / 2
            return limitToRange(keep: finalValue, within: minValue...maxValue)
        }
        set { selfValue = newValue }
    }
    public var weight: Double = baseWeight
    public var isBonus: Bool = false

    /// Initializer with a list of weighted values, flags or other sets
    public init(_ label: String, selfValue: Double? = nil, weight: Double = defaultWeight, isBonus: Bool = false, subValues: [Weighted]) {
        self.label = label
        self.selfValue = selfValue
        self.weight = limitToRange(keep: weight, within: minWeight...maxWeight)
        self.isBonus = isBonus
        self.subValues = [:]
        self.insert(subValueList: subValues)
    }
    
    /// Initializer with a variadic list of weighted values, flags or other sets
    public init(_ label: String, selfValue: Double? = nil, weight: Double = defaultWeight, isBonus: Bool = false, subValues: Weighted...) {
        self.init(label, selfValue: selfValue, weight: weight, isBonus: isBonus, subValues: subValues)
    }

    /// Gets the average values of all sub values nested in the weighted set
    private var subValuesAverage: Double? {
        let weightedMax: Double = maxValue * weight
        var weightedSum: Double = 0
        var weightedMaxSum: Double = 0
        let _ = subValues.map {
            weightedSum += ($0.value.value ?? 0) * weight
            if !$0.value.isBonus && $0.value.value != nil {
                weightedMaxSum += weightedMax * weight
            }
        }
        return weightedMaxSum > 0 ? weightedSum / weightedMaxSum : weightedSum
    }
    
    public var normalized: Double? {
        guard let value = value else { return nil }
        if weight >= baseWeight {
            let gapToMaxValue = limitToRange(keep: maxValue - value, within: minValue...maxValue)
            let percentOfMaxWeight = (weight - baseWeight) / (maxWeight - baseWeight)
            let adder = gapToMaxValue * percentOfMaxWeight
            return value + adder
        } else {
            return value * weight
        }
    }
    /// Inserts a single new subvalue
    public mutating func insert(subValue: Weighted) {
        subValues[subValue.key] = subValue
    }
    /// Insert new subvalues as a list
    public mutating func insert(subValueList: [Weighted]) {
        let _ = subValueList.map { value in insert(subValue: value) }
    }
    
    /// Insert new subvalues as a variadic
    public mutating func insert(subValues newSubValues: Weighted...) {
        insert(subValueList: newSubValues)
    }
    
    /// Creates an empty weighted set
    public static var empty: WeightedSet { return WeightedSet("", selfValue: nil, subValues: []) }
    
    // TODO: Add a + method for adding
}
