import Foundation

/**
 This defines the base requirements for a weighted value.
 
 A weighted value can come in various forms:
 - As a numeric value: Using type `WeightedValue`
 - As a boolean flag: Using type `WeightedFlag`
 - As a set containing other `Weighted` types: Using struct `WeightedSet`
​
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
public protocol Weighted: CustomStringConvertible {
    
    /// A descrptive label for the value
    var label: String { get set }
    
    /// The unweighted value stores a numerical (Double) intial value
    var value: Double? { get set }
    
    /// Weight is a multipier that either increases or decreases the value of the unweighted value
    var weight: Double { get set }
    
    /// This flag is for when this instance is combined with other instances when combined in a set. If `true`, the value is purely additive, so a low value will not penalize the overall weighted value when combined. If `false` (default), the value will affect to the overall weight (low value will penalize while high value will reward).
    var isBonus: Bool { get set }
    
    /// The value with weight applied
    var normalized: Double? { get }
    
    /// The value as an integer
    var points: Int? { get }
    
    // Peformance reflects the weighted value vs. unweighted
    // Essentially, it mirrors the wieght, but also accounts for sub-values included
    var performance: Double? { get }
    var performanceDescription: String? { get }
    
    // Unique key for instance
    var key: String { get }
}

// Default properties and methods for conforming types
public extension Weighted {
    
    var normalized: Double? {
        return normalize(possibleValue: value, weight: weight)
    }
    var performance: Double? {
        return getPerformance(value: value, normalized: normalized)
    }
    var performanceDescription: String? {
        return getPerformanceDescription(performance: performance)
    }
    
    var points: Int? {
        return getPoints(possibleValue: value)
    }
    
    /// For string descriptions
    var description: String {
        guard let value = value else { return "\(label): \(notApplicable)" }
        let valueString = "\(Int(value))"
        let points = getPoints(value: value)
        let normalized = normalize(value: value, weight: weight)
        let normalizedString = "\(Int(normalized))"
        let performance = getPerformance(value: value, normalized: normalized)
        let performanceDescription = getPerformanceDescription(performance: performance)
        return "\(label): \(points) points (Performance: \(performanceDescription), Unweighted: \(valueString), Normalized: \(normalizedString))"
    }
    
    /// Establishes a key for each value
    var key: String {
        return "\(label)_\(weight)_\(value ?? 0)"
    }
    
    /// Hash function
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(value)
        hasher.combine(weight)
    }
    
    /// For comparing to other instances
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.normalized ?? 0 < rhs.normalized ?? 0
    }
    
    /// For determining equality with other instances
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.normalized == rhs.normalized
    }
}
