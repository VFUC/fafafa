//
//  ConfigModifier.swift
//  
//
//  Created by Jonas Wippermann on 28.12.21.
//

import Foundation
import Yams

struct ConfigModifier {
    struct NodeModification {
        /// The value of the node should be modified
        let value: Any
        /// A sibling should be added to the node
        let sibling: (key: String, value: Any)?
    }

    /// Returns valid, modified YAML
    /// NOTE: returned YAML will be sorted lexicographically (a-z for each key hierarchy)!
    /// - Parameter input: The yaml string to modify
    /// - Returns: YAML string modified based on rules
    static func modify(_ config: String, modifications: [Modification]) throws -> String {
        let yamlDict = try Helper.getDictFromYAMLString(config)
        let modifiedDict = handleNodeModify(yamlDict, modifications: modifications)
        let output = try Yams.dump(object: modifiedDict, sortKeys: true)
        
        return output.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func handleNodeModify(_ node: [String: Any], prefix: String = "", modifications: [Modification]) -> [String: Any] {

        return node.reduce(into: [String: Any]()) { partialResult, subNode in

            // check for possible modification applying to this node
            if let leafModification = handleLeafNodeModify(key: subNode.key, value: subNode.value, prefix: prefix, modifications: modifications) {
                partialResult[subNode.key] = leafModification.value

                // if we have a sibling node, it must be added here
                if let sibling = leafModification.sibling {
                    partialResult[sibling.key] = sibling.value
                }
            } else if let subDict = subNode.value as? [String: Any] {
                // handle 'branch' node by calling `handleNode` recursively
                let subPrefix = prefix == "" ? "\(subNode.key)" : "\(prefix).\(subNode.key)"
                partialResult[subNode.key] = handleNodeModify(subDict, prefix: subPrefix, modifications: modifications)
            } else if let subNodeArray = subNode.value as? [[String: Any]] {
                var index = 0
                var allChildModifiedNodes = [[String: Any]]()
                for childNode in subNodeArray {
                    let subPrefix = prefix == "" ? "\(subNode.key).\(index)" : "\(prefix).\(subNode.key).\(index)"
                    allChildModifiedNodes.append(handleNodeModify(childNode, prefix: subPrefix, modifications: modifications))
                    index += 1
                }
                partialResult[subNode.key] = allChildModifiedNodes

            } else if let subValueArray = subNode.value as? [Any] {
                var index = 0
                var modifiedValues = [Any]()
                for value in subValueArray {
                    let subPrefix = prefix == "" ? "\(subNode.key)" : "\(prefix).\(subNode.key)"

                    modifiedValues.append(handleLeafNodeModify(key: "\(index)", value: value, prefix: subPrefix, modifications: modifications)?.value ?? value)
                    index += 1
                }
                partialResult[subNode.key] = modifiedValues
            } else {
                partialResult[subNode.key] = subNode.value
            }
        }
    }

    private static func handleLeafNodeModify(key: String, value: Any, prefix: String, modifications: [Modification]) -> NodeModification? {
        let path = "\(prefix).\(key)"

        if let matchingModification = modifications.first(where: { $0.node.path == path }) {
            return NodeModification(value: matchingModification.violation.modify(value), sibling: matchingModification.violation.sibling)
        }
        return nil
    }
}

