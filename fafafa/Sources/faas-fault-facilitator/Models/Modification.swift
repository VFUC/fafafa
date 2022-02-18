//
//  Modification.swift
//  
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation

/// The desired modification to partake
struct Modification {
    /// The node to apply the modification to
    let node: MatchedNode
    /// The constraint violation used to perform the modification
    let violation: ConstraintViolation
}

extension Modification: CustomStringConvertible {
    var description: String {
        "node: \(node) | violation: \(violation)"
    }
}
