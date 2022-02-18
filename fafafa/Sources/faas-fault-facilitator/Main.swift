import ArgumentParser
import Foundation

@main
struct Main: ParsableCommand {

    @Option(name: .shortAndLong, help: "Where to write the output to")
    var outputFile: String?

    @Argument(help: "Path to input config file")
    var configFilePath: String

    func run() throws {
        print("Parsing file...")

        var isDir: ObjCBool = false
        guard FileManager.default.fileExists(atPath: configFilePath, isDirectory: &isDir) else {
            throw ValidationError("File at path '\(configFilePath)' does not exist.")
        }

        guard !isDir.boolValue else {
            throw ValidationError("'\(configFilePath)' is a directory, not a file.")
        }

        let value = try String(contentsOfFile: configFilePath)

        let matchedNodes: [MatchedNode] = try ConfigAnalyzer.analyze(value)
            .sorted(by: { $0.path < $1.path }) // sorting makes repeated output consistent

        print("✓ Analysis has recognized the following nodes:")

        let chosenNode: MatchedNode = try UserInput.getArrayChoice(array: matchedNodes, prompt: "Which node should be modified?")
        print("Node choice: \(chosenNode)")

        print("\nConstraints for this node's configuration option")
        let chosenConstraint: OptionConstraint = try UserInput.getArrayChoice(array: chosenNode.configurationOption.constraints)
        print("Constraint choice: \(chosenConstraint)")

        print("\nPossible violations for this constraint")
        let chosenViolation: ConstraintViolation = try UserInput.getArrayChoice(array: chosenConstraint.violations)
        print("Violation choice: \(chosenViolation)")

        let modifications = [Modification(node: chosenNode, violation: chosenViolation)]

        print("Running modification...")
        let modifiedConfiguration = try ConfigModifier.modify(value, modifications: modifications)
        print("✓ Configuration modified")

        if let outputFile = outputFile {
            let fileURL = URL(fileURLWithPath: outputFile)
            try modifiedConfiguration.write(to: fileURL, atomically: true, encoding: .utf8)
            print("✓ Wrote modification to \(fileURL.absoluteString)")
        } else {
            print("No output file specified. Modification result:")
            print(modifiedConfiguration)
        }
    }
}
