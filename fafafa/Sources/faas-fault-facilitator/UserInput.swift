//
//  File.swift
//  
//
//  Created by Jonas Wippermann on 30.01.22.
//

import Foundation

class UserInput {
    enum Error: Swift.Error {
        case badUserInput
    }

    static func getInput(prompt: String) -> String? {
        print(prompt)
        guard let read = readLine() else { return nil }
        return read
    }

    static func getMultipleChoiceInput(prompt: String, choices: [String]) -> String {
        while true {
            print("➤ " + prompt + " [\(choices.joined(separator: ", "))]")
            guard let read = readLine() else { break }
            if choices.contains(read) {
                return read
            } else if read == "" && choices.count == 1 {
                return choices.first!
            } else {
                print("Unexpected input")
            }
        }
        return "" // should never occur
    }

    static func getArrayIndexUserChoice(prompt: String, numberOfChoices: Int) -> String {
        while true {
            if numberOfChoices == 1 {
                print("\n➤ Only one choice available for this option. [enter] to choose it")
            } else {
                print("\n➤ " + prompt + " [0 - \(numberOfChoices - 1)]")
            }

            let choices = (0..<numberOfChoices).map(String.init)
            guard let read = readLine() else { break }
            if choices.contains(read) {
                return read
            } else if read == "" && choices.count == 1 {
                return choices.first!
            } else {
                print("Unexpected input")
            }
        }
        return "" // should never occur
    }



    static func getArrayChoice<T>(array: Array<T>, prompt: String = "Which one do you choose?") throws -> T {
        for (index, elem) in array.enumerated() {
            print("[\(index)] \(elem)")
        }
        let chosenIndex = UserInput.getArrayIndexUserChoice(prompt: prompt, numberOfChoices: array.count)

        guard let index = Int(chosenIndex), array.indices.contains(index) else {
            throw Error.badUserInput
        }
        return array[index]
    }
}
