//
//  File.swift
//  
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation

/// A node in the configuration that has been "parsed", so the key was recognized and a matched configurationOption was stored
struct MatchedNode {

    /// Path in configuration tree
    let path: String

    /// The recognized configuration option associated with the node's key
    let configurationOption: ConfigurationOption
}

extension MatchedNode: CustomStringConvertible {
    var description: String {
        path
    }
}
