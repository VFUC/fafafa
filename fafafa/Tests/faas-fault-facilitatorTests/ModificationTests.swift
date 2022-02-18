//
//  ModificationTests.swift
//  
//
//  Created by Jonas Wippermann on 28.12.21.
//

import XCTest
@testable import faas_fault_facilitator

class ModificationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRandomEndToEndModification() throws {
        let input = TestBedConfigurations.nodeHTTPApiConfig
        let matchedNodes: [MatchedNode] = try ConfigAnalyzer.analyze(input)
        let firstMatchedNode = try XCTUnwrap(matchedNodes.first)
        let randomConstraint = try XCTUnwrap(firstMatchedNode.configurationOption.constraints.randomElement())
        let randomViolation = try XCTUnwrap(randomConstraint.violations.randomElement())
        let modification = Modification(node: firstMatchedNode, violation: randomViolation)
        let outputNoModification = try ConfigModifier.modify(input, modifications: [])
        let outputWithModification = try ConfigModifier.modify(input, modifications: [modification])
        print(outputNoModification)
        print(outputWithModification)
        XCTAssertNotEqual(outputNoModification, outputWithModification)
    }

    /// One-by-one applies ALL violations to ALL constraints of ALL matched nodes from the input
    /// This will fail if one of the applied violations does not modify the input
    func testAllEndToEndModifications() throws {
        let input = TestBedConfigurations.nodeHTTPApiConfig
        let outputNoModification = try ConfigModifier.modify(input, modifications: [])
        let matchedNodes: [MatchedNode] = try ConfigAnalyzer.analyze(input)

        for matchedNode in matchedNodes {
            for constraint in matchedNode.configurationOption.constraints {
                for violation in constraint.violations {
                    let modification = Modification(node: matchedNode, violation: violation)
                    let outputWithModification = try ConfigModifier.modify(input, modifications: [modification])
                    XCTAssertNotEqual(outputNoModification, outputWithModification, modification.description)
                }
            }
        }
    }
}
