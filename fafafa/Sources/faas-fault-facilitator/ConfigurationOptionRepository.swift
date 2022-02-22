//
//  ConfigurationOptionRepository.swift
//
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation

/// Stores all known configuration option and their constraints
struct ConfigurationOptionRepository {
    private static func configurationOption(for key: String) -> ConfigurationOption? {
        switch key {
        case "region":
            return ConfigurationOption(constraints: [
                EnumerationConstraint(expectedValues: AWS.regions, unexpectedValues: ["eu-central-3", "us-north-1"])])
        case "image":
            return ConfigurationOption(constraints: [ReferenceConstraint(),
                                                               AtMostOneConstraint(key: key, optionsWithValidValues: [
                                                                "image": "abcmyImage",
                                                                "package": ["artifact": "handler.zip"]
                                                               ]),
                                                              ])
        case "package":
            return ConfigurationOption(constraints: [AtMostOneConstraint(key: key, optionsWithValidValues: [
                "image": "abcmyImage",
                "package": ["artifact": "handler.zip"]
            ])])

        case "architecture":
            return ConfigurationOption(constraints: [
                EnumerationConstraint(expectedValues: AWS.architectures, unexpectedValues: ["x86_32", "arm32", "windows"])])
        case "runtime":
            return ConfigurationOption(constraints: [
                EnumerationConstraint(expectedValues: AWS.runtimes, unexpectedValues: ["cplusplus", "nodejs8.x"]
                                     )])

        case "layers", "securityGroupIds", "subnetIds": // these are all collections of references
            return ConfigurationOption(valueRequirement: { $0 is [String] },
                                       constraints: [ReferenceConstraint()]) // applied to each value in the collection
        case "timeout":
            return ConfigurationOption(constraints: [NumericRangeConstraint(range: 1...900), WholeNumberConstraint()])
        case "memorySize":
            return ConfigurationOption(constraints: [NumericRangeConstraint(range: 128...10240),
                                                               WholeNumberConstraint()])
        case "maximumEventAge":
            return ConfigurationOption(constraints: [NumericRangeConstraint(range: 60...21600), WholeNumberConstraint()])
        case "maximumRetryAttempts":
            return ConfigurationOption(constraints: [NumericRangeConstraint(range: 0...2),
                                                               WholeNumberConstraint()])
        case "environment":
            return ConfigurationOption(constraints: [
                NotReservedConstraint(reservedValues: AWS.reservedEnvironmentValues)
            ])

        case "events":
            return ConfigurationOption(constraints: [], childOptionFactory: eventsFactory)
        case "handler":
            return ConfigurationOption(constraints: [ReferenceConstraint()])
        case "provisionedConcurrency":
            return ConfigurationOption(constraints: [NumericRangeConstraint(range: 0...1000), WholeNumberConstraint()])
        case "reservedConcurrency":
            return ConfigurationOption(constraints: [NumericRangeConstraint(range: 0...1000),
                                                               WholeNumberConstraint()])

        case "artifact":
            return ConfigurationOption(constraints: [ReferenceConstraint()])

        case "role":
            return ConfigurationOption(valueRequirement: { $0 is String }, constraints: [ReferenceConstraint()])

        case "statements":
            return ConfigurationOption(constraints: [], childOptionFactory: statementsFactory)

        default:
            return nil
        }
    }


    /// Configuration option mapping for the "statements" sub-node
    static func statementsConfigurationOption(for key: String) -> ConfigurationOption? {
        switch key {
        case "Effect":
            return ConfigurationOption(constraints: [
                EnumerationConstraint(expectedValues: ["Allow", "Deny"], unexpectedValues: ["Transfer"])
            ])
        case "Action":
            return ConfigurationOption(constraints: [
                EnumerationConstraint(expectedValues: AWS.s3IAMActions,
                                      unexpectedValues: AWS.nonExistentS3IAMActions)
            ])
        case "Resource":
            #if os(macOS) // only available on macOS
            return ConfigurationOption(constraints: [
                PatternMustMatchConstraint(targetedResources: ["arn:aws:s3:::awstestbed.mybucket/doge.jpeg"],
                                           patternMatches: PatternMustMatchConstraint.wildcardsPatternMatcher)
            ])
            #else
            return nil
            #endif
        default:
            return nil
        }
    }

    /// Configuration option mapping for the "events" sub-node
    private static func eventsConfigurationOption(for key: String) -> ConfigurationOption? {
        switch key {
        case "httpApi":
            return ConfigurationOption(constraints: []) { httpChildKey in
                switch httpChildKey {
                case "method":
                    return ConfigurationOption(constraints: [
                        EnumerationConstraint(expectedValues: AWS.httpMethods,
                                              unexpectedValues: ["got", "foot", "package"])
                    ])
                default:
                    return nil
                }
            }
        default:
            return nil
        }
    }

    /// Default Configuration Option matching, to be used from root node
    static var defaultFactory: ConfigurationOptionFactory {
        return configurationOption
    }

    /// Matching for the "events" sub-node
    static var eventsFactory: ConfigurationOptionFactory {
        return eventsConfigurationOption
    }

    /// Matching for the "statements" sub-node
    static var statementsFactory: ConfigurationOptionFactory {
        return statementsConfigurationOption
    }
}
