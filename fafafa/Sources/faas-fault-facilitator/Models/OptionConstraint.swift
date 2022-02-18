//
//  File.swift
//  
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation

/// Represents a constraint that may apply to a configuration option
/// Can be implemented by concrete constraints
protocol OptionConstraint {

    /// Constraint name, used for user selection
    var name: String { get }

    /// Constraint description, used for user selection
    var description: String { get }

    /// Ways to violate this constraint
    var violations: [ConstraintViolation] { get }
}
