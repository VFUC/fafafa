//
//  File.swift
//  
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation

/// A known configuration option, defined by its key and the constraints that apply to it
struct ConfigurationOption {

    /// Optional value requirement, can be used to restrict node matching to specific values (e.g. type)
    var valueRequirement: ((Any) -> Bool)? = nil

    /// Constraints that apply to this option
    let constraints: [OptionConstraint]

    /// Optional factory for configuration options applying to the children of this node
    /// This implies that this node holds sub-nodes either as dictionary or as array of dictionaries
    var childOptionFactory: (ConfigurationOptionFactory)? = nil
}
