//
//  ReferenceConstraint.swift
//  
//
//  Created by Jonas Wippermann on 11.02.22.
//

import Foundation

struct ReferenceConstraint: OptionConstraint, CustomStringConvertible {

    var name: String {
        "Reference"
    }

    var description: String {
        "\(name): Value must be a valid reference"
    }

    private let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    var violations: [ConstraintViolation] {
        return [
            .init(
                  name: "Add random characters",
                  description: "Appends random characters to the end of the reference", modify: { input in
                      guard let stringInput = input as? String else { return input }
                      let numberOfAddChars = (3...10).randomElement()!
                      let randomChars = (0..<numberOfAddChars).map({ _ in letters.randomElement()! })
                      return stringInput + String(randomChars)
            }),
            .init(
                  name: "Change random characters",
                  description: "Changes random characters inside of the reference", modify: { input in
                      guard let stringInput = input as? String else { return input }
                      var arrayString = Array(stringInput)
                      let numberOfChangeChars = (5...10).randomElement()!
                      (0..<numberOfChangeChars).map({ _ in
                          arrayString.indices.randomElement()!
                      }).forEach({ randomIndex in
                          // only change if previous letter was also a-zA-Z0-9 (tries to remain syntactically correct)
                          if letters.contains(arrayString[randomIndex]) {
                              arrayString[randomIndex] = letters.randomElement()!
                          }
                      })
                      return String(arrayString)
            }),
            .init(
                  name: "Remove random characters",
                  description: "Removes random characters from the reference", modify: { input in
                      guard let stringInput = input as? String else { return input }
                      guard stringInput.count > 1 else { return input } // reference too short to remove more
                      let numberOfRemoveChars = (1...Int(stringInput.count / 2)).randomElement()!

                      var arrayString = Array(stringInput)
                      (0..<numberOfRemoveChars).forEach { _ in
                          arrayString.remove(at: arrayString.indices.randomElement()!)
                      }
                      return String(arrayString)
            })
        ]
    }
}
