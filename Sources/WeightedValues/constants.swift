import Foundation

/*
 # Constants
 */

/// Minimum value allowed. Values below this will be increased to the minimum.
let minValue: Double = 0
/// Maximum value allowed. Values over this will be truncated to the maximum.
let maxValue: Double = 100

/// Minimum weight allowed. Weights below this will be increased to the minimum.
let minWeight: Double = 0
/// The weight considered to be the normal weight (no weight applied to the base value).
let baseWeight: Double = 1
/// The default weight for paramaters without specified weights
public let defaultWeight: Double = baseWeight
/// Maximum weight allowed. Weights over this will be truncated to the maximum.
let maxWeight: Double = 10

/// String constant for non-applicable values
let notApplicable = "Not applicable"
