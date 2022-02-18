//
//  Helper.swift
//  
//
//  Created by Jonas Wippermann on 31.01.22.
//

import Foundation
import Yams

struct Helper {
    enum ParserError: Error {
        case invalidInput
    }

    /// Takes string, interprets as YAML, returns as dictionary if possible
    /// - Parameter input: yaml input string
    /// - Returns: key-value dictionary of parsed YAML content
    static func getDictFromYAMLString(_ input: String) throws -> [String: Any] {
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        let yaml = try Yams.load(yaml: trimmedInput)
        guard let yamlDict = yaml as? [String: Any] else {
            throw ParserError.invalidInput
        }
        return yamlDict
    }
}
