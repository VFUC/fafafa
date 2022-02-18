//
//  AtMostOneConstraint.swift
//  
//
//  Created by Jonas Wippermann on 11.02.22.
//

import Foundation

struct AtMostOneConstraint: OptionConstraint, CustomStringConvertible {

    let key: String

    let optionsWithValidValues: [String: Any]

    var name: String {
        "At Most One"
    }

    var description: String {
        "\(name): At most one of the options [\(optionsWithValidValues.keys.joined(separator: ", "))] may be specified at once"
    }

    var violations: [ConstraintViolation] {
        return [
            .init(
                  name: "Use more than one",
                  description: "Use more than one of the specified options", modify: { value in
                      return value
                  }, sibling: optionsWithValidValues.first(where: { $0.key != key }))
        ]
    }
}
