//
//  ParsingTests.swift
//  
//
//  Created by Jonas Wippermann on 12.02.22.
//

import XCTest
import class Foundation.Bundle
@testable import faas_fault_facilitator


final class NodeMatchingTests: XCTestCase {

    func testRegionMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "provider.region" }))
    }

    func testImageMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.imageHello.image" }))
    }

    func testPackageMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.packagedHello.package" }))
    }

    func testArchitectureMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.hello.architecture" }))
    }

    func testRuntimeMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.hello.runtime" }))
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.bye.runtime" }))
    }

    func testLayerMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.bye.layers.0" }))
    }

    func testTimeoutMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.bye.timeout" }))
    }

    func testMemorySizeMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.hello.memorySize" }))
    }


    func testEventAgeMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.bye.maximumEventAge" }))
    }

    func testRetryAttemptsMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.hello.maximumRetryAttempts" }))
    }

    func testEnvironmentMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.hello.environment" }))
    }

    func testEventsMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.hello.events.0.httpApi.method" }))
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.bye.events.0.httpApi.method" }))
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.imageHello.events.0.httpApi.method" }))
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.packagedHello.events.0.httpApi.method" }))
    }

    func testHandlerMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.hello.handler" }))
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.bye.handler" }))
    }

    func testProvisionedConcurrencyMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.bye.provisionedConcurrency" }))
    }

    func testReservedConcurrencyMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.bye.reservedConcurrency" }))
    }

    func testVPCConfigMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.hello.vpc.securityGroupIds.0" }))
        XCTAssert(matchedNodes.contains(where: { $0.path == "functions.hello.vpc.subnetIds.0" }))
    }

    func testIAMConfigMatching() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        XCTAssert(matchedNodes.contains(where: { $0.path == "provider.iam.role.statements.0.Effect" }))
        XCTAssert(matchedNodes.contains(where: { $0.path == "provider.iam.role.statements.0.Resource" }))
        XCTAssert(matchedNodes.contains(where: { $0.path == "provider.iam.role.statements.0.Action" }))
    }

    func testNoDuplicateNodes() throws {
        let matchedNodes = try ConfigAnalyzer.analyze(TestBedConfigurations.nodeHTTPApiConfig)
        let nodePaths = matchedNodes.map(\.path)
        let pathsAsSet = Set(nodePaths) // this removes duplicates
        XCTAssertEqual(nodePaths.count, pathsAsSet.count, "Node paths must be unique - duplicates not permitted")
    }
}
