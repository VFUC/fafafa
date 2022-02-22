//
//  File.swift
//  
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation

typealias ConfigurationOptionFactory = (String) -> ConfigurationOption?

struct ConfigAnalyzer {


    /// Returns matched keys
    /// - Parameter input: The yaml config string
    /// - Returns: list of matched keys
    static func analyze(_ config: String) throws -> [MatchedNode] {
        let yamlDict = try ParsingHelper.getDictFromYAMLString(config)
        return handleNodeAnalyze(yamlDict)
    }


    /// Recursive node analysation, to be started with root node and default parameters
    ///
    /// - Parameters:
    ///   - node: the current node to analyze recursively
    ///   - prefix: hierarchical prefix used to construct absolute node paths
    ///   - optionFactory: The factory method that should be used to match configuration keys with their known options - may change when handling nested options
    /// - Returns: All recognized configuration option nodes as `MatchedNode` objects
    private static func handleNodeAnalyze(_ node: [String: Any],
                                          prefix: String = "",
                                          optionFactory: ConfigurationOptionFactory = ConfigurationOptionRepository.defaultFactory) -> [MatchedNode] {
        return node.reduce(into: [MatchedNode]()) { partialResult, subNode in

            if let parsedNode = handleLeafNodeAnalyze(key: subNode.key, value: subNode.value, prefix: prefix, optionFactory: optionFactory) {
                partialResult.append(contentsOf: parsedNode)
            }
            if let subDict = subNode.value as? [String: Any] {
                let subPrefix = prefix == "" ? "\(subNode.key)" : "\(prefix).\(subNode.key)"
                partialResult.append(contentsOf: handleNodeAnalyze(subDict, prefix: subPrefix))
            }
        }
    }

    /// If the passed key is recognized with the given factory, a set of `MatchedNode` objects is returned
    /// - Parameters:
    ///   - key: key of the node to inspect
    ///   - value: value of node to inspect
    ///   - prefix: prefix used for absolute path construction
    ///   - optionFactory: factory method to be used for configuration option matching
    /// - Returns: a set of matched parsed nodes, if any - nil if nothing could be matched
    private static func handleLeafNodeAnalyze(key: String, value: Any, prefix: String, optionFactory: ConfigurationOptionFactory) -> [MatchedNode]? {
        let path = "\(prefix).\(key)"

        // key not matched, return
        guard let matchedOption = optionFactory(key) else { return nil }
        if let valueConstraint = matchedOption.valueRequirement, valueConstraint(value) == false {
            return nil // value constraint does not hold -> abort
        }

        // If the matched node has an option factory for a collection of child nodes, try to decode child nodes and handle those
        if let childOptionFactory = matchedOption.childOptionFactory, let childCollection = value as? [[String: Any]] {
            var index = 0
            var allChildParsedNodes = [MatchedNode]()
            for childNode in childCollection {
                let childPath = "\(path).\(index)"
                let childParsedNodes = handleNodeAnalyze(childNode, prefix: childPath, optionFactory: childOptionFactory)
                allChildParsedNodes.append(contentsOf: childParsedNodes)
                index += 1
            }
            return allChildParsedNodes
        } else if let childOptionFactory = matchedOption.childOptionFactory, let childNode = value as? [String: Any] {
            return handleNodeAnalyze(childNode, prefix: path, optionFactory: childOptionFactory)
        } else if let childArray = value as? [Any] {
            var index = 0
            var allChildParsedNodes = [MatchedNode]()
            // no key-based matching, values only, so adopt config options from parent
            for _ in childArray {
                let childPath = "\(path).\(index)"
                allChildParsedNodes.append(MatchedNode(path: childPath, configurationOption: matchedOption))
                index += 1
            }
            return allChildParsedNodes
        } else {
            return [MatchedNode(path: path, configurationOption: matchedOption)]
        }
    }
}
