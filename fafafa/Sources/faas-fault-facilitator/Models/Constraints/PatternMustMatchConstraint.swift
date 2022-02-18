//
//  PatternMustMatchConstraint.swift
//
//
//  Created by Jonas Wippermann on 11.02.22.
//

import Foundation

struct PatternMustMatchConstraint: OptionConstraint, CustomStringConvertible {
    typealias Resource = String
    typealias Pattern = String

    let targetedResources: Set<Resource>
    let patternMatches: (Pattern, Resource) -> Bool

    var name: String {
        "Pattern Must Match"
    }

    var description: String {
        "\(name): The pattern specified by the value must match the targeted resources [\(targetedResources.joined(separator: ", "))]"
    }

    var violations: [ConstraintViolation] {
        return [
            .init(
                name: "Non-matching pattern",
                description: "Modify the pattern so that it does not match the targeted resources", modify: { input in
                    guard var pattern = input as? Pattern else { return input }

                    var doesMatch = targetedResources.contains(where: { patternMatches(pattern, $0) })
                    while doesMatch {
                        pattern = String(pattern.shuffled())
                        doesMatch = targetedResources.contains(where: { patternMatches(pattern, $0) })
                    }

                    return pattern
                })
        ]
    }
}

/// Wildcard matching requires macOS
#if os(macOS)
extension PatternMustMatchConstraint {
    /// based on https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_resource.html
    /// "An asterisk (*) represents any combination of characters and a question mark (?) represents any single character"
    static let wildcardsPatternMatcher: (Pattern, Resource) -> Bool = { pattern, resource in
        let pred = NSPredicate(format: "self LIKE %@", pattern)
        return !NSArray(object: resource).filtered(using: pred).isEmpty
    }
}
#endif
