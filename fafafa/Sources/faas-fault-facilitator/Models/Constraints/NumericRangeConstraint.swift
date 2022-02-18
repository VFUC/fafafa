//
//  NumericRangeConstraint.swift
//  
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation

struct NumericRangeConstraint: OptionConstraint, CustomStringConvertible {

    let range: ClosedRange<Int>

    var name: String {
        "Numeric Range"
    }

    var description: String {
        "\(name): Value must be inside of numeric range (\(range.lowerBound) - \(range.upperBound))"
    }

    var violations: [ConstraintViolation] {
        return [
            .init(
                  name: "Exceed upper",
                  description: "Value above highest permitted range", modify: { _ in
                return range.upperBound + 1
            }),
            .init(
                  name: "Under lower",
                  description: "Value below lowest permitted range", modify: { _ in
                return range.lowerBound - 1
            })
        ]
    }
}
