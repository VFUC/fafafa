//
//  File.swift
//  
//
//  Created by Jonas Wippermann on 11.02.22.
//

import Foundation

struct WholeNumberConstraint: OptionConstraint, CustomStringConvertible {

    var name: String {
        "Whole Number"
    }

    var description: String {
        "\(name): Value must be whole-numbered"
    }

    var violations: [ConstraintViolation] {
        return [
            .init(
                  name: "Add fraction",
                  description: "Add fraction to current value", modify: { value in
                      if let intValue = value as? Int { // input value should be an int (whole number)
                          let doubleValue = Double(intValue)
                          return doubleValue + 0.42
                      }
                      return value
            })
        ]
    }
}
