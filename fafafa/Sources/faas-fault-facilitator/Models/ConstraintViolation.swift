//
//  ConstraintViolation.swift
//  
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation


/// Holds the information needed to invoke a constraint violation
struct ConstraintViolation: CustomStringConvertible {

    /// Violation name, used for user selection
    let name: String

    /// Violation description, used for user selection
    let description: String

    /// Executes violation modification, input: given configuration value, output: modified configuration value
    let modify: (Any) -> Any

    /// May return a sibling configuration option that should be added to the inspected node
    var sibling: (String, Any)? = nil
}

