import Foundation

/*
 # Utility Functions
 */

/**
 Limits the value of the input to the specified range. If the input is under the range, it will be increased to the minimum value. If the input is over the range, it will be truncated to the maximum value.
 - Parameter input: The value need to limit.
 - Parameter range: The closed range the value must fall within.
 - Returns: Returns the limited value that is guaranteed to fall within the specified range.
 
 # Example
 ```
 let limited = limitToRange(keep: 23, within 0...10)
 print(limited) // Prints '10'
 ```
 
 - Author: Justin Reusch
 - Date: July 31, 2019
 */
func limitToRange<T: Comparable>(keep input: T, within range: ClosedRange<T>) -> T {
    if input > range.upperBound {
        return range.upperBound
    } else if input < range.lowerBound {
        return range.lowerBound
    } else {
        return input
    }
}

/**
 Utility function to normalize a weighted value between min and max values based on weight.
 - Parameter possibleValue: The original value to normalize (Can be `nil` if not applicable).
 - Parameter range: The weight applied to the value.
 - Returns: Returns a weighted value between min and max values based on weight.
 
 - Author: Justin Reusch
 - Date: July 31, 2019
 */
func normalize(possibleValue: Double?, weight: Double) -> Double? {
    guard let value = possibleValue else { return nil }
    return normalize(value: value, weight: weight)
}

/**
 Utility function to normalize a weighted value between min and max values based on weight.
 - Parameter value: The original value to normalize.
 - Parameter range: The weight applied to the value.
 - Returns: Returns a weighted value between min and max values based on weight.
 
 - Author: Justin Reusch
 - Date: July 31, 2019
 */
func normalize(value: Double, weight: Double) -> Double {
    if weight >= baseWeight {
        let gapToMaxValue = limitToRange(keep: maxValue - value, within: minValue...maxValue)
        let percentOfMaxWeight = (weight - baseWeight) / (maxWeight - baseWeight)
        let adder = gapToMaxValue * percentOfMaxWeight
        return value + adder
    } else {
        return value * weight
    }
}

/**
 Utility to measure the performance of a normalized value vs. original value.
 - Parameter value: The original value.
 - Parameter normalized: The normalized value.
 - Returns: Returns a ratio of the normalized value vs. original value.
 
 - Author: Justin Reusch
 - Date: July 31, 2019
 */
func getPerformance(value: Double?, normalized: Double?) -> Double? {
    guard let value = value, let normalized = normalized else { return nil }
    return value > 0 ? normalized / value : nil
}

/**
 Formats a string representation of the performance.
 - Parameter performance: The calculated performance.
 - Returns: A string representation of the performance.
 
 - Author: Justin Reusch
 - Date: July 31, 2019
 */
func getPerformanceDescription(performance: Double?) -> String {
    guard let performance = performance else { return "0%" }
    return "\(Int(performance * 100))%"
}

/**
 Points is simply an Integer representation of the value (for simplicity).
 - Parameter possibleValue: The original value as a Double.
 - Returns: A value as an Integer.
 
 - Author: Justin Reusch
 - Date: July 31, 2019
 */
func getPoints(possibleValue: Double?) -> Int? {
    guard let value = possibleValue else { return nil }
    return getPoints(value: value)
}

/**
 Points is simply an Integer representation of the value (for simplicity).
 - Parameter value: The original value as a Double.
 - Returns: A value as an Integer.
 
 - Author: Justin Reusch
 - Date: July 31, 2019
 */
func getPoints(value: Double) -> Int {
    return Int(value)
}
