//
//  EnumerationConstraint.swift
//  
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation
import StringMetric

struct EnumerationConstraint<T: Hashable>: OptionConstraint, CustomStringConvertible {

    let expectedValues: Set<T>
    let unexpectedValues: Set<T> // Note: we can't really auto-compute this violation, so make it explicit

    var name: String {
        "Enumeration"
    }

    var description: String {
        "\(name): Value must be one of the expected values"
    }

    var violations: [ConstraintViolation] {
        var v: [ConstraintViolation] = [
            .init(
                name: "Unexpected value",
                description: "Value not from set of expected values", modify: { _ in
                    return unexpectedValues.randomElement()!
                })
        ]
        if let expectedStringValues = expectedValues as? Set<String> {
            v.append(.init(name: "Expected but different value",
                           description: "A value from the set of expected values, but 'as different as possible' from the current one", modify: { input in
                guard let inputString = input as? String else { return input }
                let workingSet = expectedStringValues.subtracting([inputString])
                let mostDistancedOption = workingSet.max(by: { $0.distanceLevenshtein(between: inputString) < $1.distanceLevenshtein(between: inputString) })
                return mostDistancedOption ?? inputString
            }))
        }
        return v
    }
}
