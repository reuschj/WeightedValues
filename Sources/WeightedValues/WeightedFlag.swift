import Foundation

/**
 A weighted boolean value that is simply either true or false.
 
 # Example
 ```
 let isEnabled = WeightedFlag("Is Enabled", is: true, weight: 1.8, isBonus: false)
 ```
 
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
public struct WeightedFlag: Weighted, Hashable, Comparable {
    
    public var label: String = ""
    
    public var value: Double? {
        get { return flag ? 100 : 0 }
        set {
            guard let newValue = newValue else { return }
            flag = newValue > 0
        }
    }
    /// A boolean flag describing the value
    public var flag: Bool = false
    public var weight: Double = baseWeight
    public var isBonus: Bool = false
    
    /// Initializer for weighted flag
    public init(_ label: String, is flag: Bool, weight: Double = defaultWeight, isBonus: Bool = false) {
        self.label = label
        self.flag = flag
        self.weight = limitToRange(keep: weight, within: minWeight...maxWeight)
        self.isBonus = isBonus
    }
    
    /// Creates an empty weighted flag.
    public static var empty: WeightedFlag { return WeightedFlag("", is: false) }
    
}
