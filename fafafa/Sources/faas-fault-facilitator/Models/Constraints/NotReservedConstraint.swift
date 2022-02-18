//
//  NotReservedConstraint.swift
//  
//
//  Created by Jonas Wippermann on 11.02.22.
//

import Foundation

struct NotReservedConstraint<T: Hashable>: OptionConstraint, CustomStringConvertible {
    
    let reservedValues: Set<T>

    var name: String {
        "Not Reserved"
    }

    var description: String {
        "\(name): Value must not be one of the reserved values"
    }

    var violations: [ConstraintViolation] {
        return [
            .init(
                name: "Reserved value",
                description: "Use reserved value", modify: { input in

                    if var inputDict = input as? [String: Any], let reservedString = reservedValues.randomElement() as? String {
                        inputDict[reservedString] = "MODIFIED_VALUE"
                        return inputDict
                    }

                    // input is not dict
                    return reservedValues.randomElement()!
                })
        ]
    }
}
