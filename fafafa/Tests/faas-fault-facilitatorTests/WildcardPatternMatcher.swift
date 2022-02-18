//
//  WildcardPatternMatcher.swift
//  
//
//  Created by Jonas Wippermann on 12.02.22.
//

import XCTest
@testable import faas_fault_facilitator

class WildcardPatternMatcher: XCTestCase {

#if os(macOS)
    func testPatternMatching() throws {
        XCTAssertTrue(PatternMustMatchConstraint.wildcardsPatternMatcher("myBucket/*", "myBucket/myResource"))
        XCTAssertTrue(PatternMustMatchConstraint.wildcardsPatternMatcher("myBucket/*/path", "myBucket/myResource/path"))
        XCTAssertTrue(PatternMustMatchConstraint.wildcardsPatternMatcher("myBucket/*/path/*/", "myBucket/myResource/path/mySubPath/"))
        XCTAssertTrue(PatternMustMatchConstraint.wildcardsPatternMatcher("myBucket/???/path", "myBucket/abc/path"))
        XCTAssertTrue(PatternMustMatchConstraint.wildcardsPatternMatcher("myBucket/???/path/*", "myBucket/abc/path/abcde"))
    }
#endif
}
