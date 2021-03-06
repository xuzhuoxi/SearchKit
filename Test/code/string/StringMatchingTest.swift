//
//  StringMatchingTest.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/25.
//
//

import XCTest
@testable import SearchKit

class StringMatchingTest: XCTestCase {
    fileprivate var source:String="adfeff";
    fileprivate var expression:String="aff";
    fileprivate var resultMatching=[true, false, true, false, true, false];
    fileprivate var resultCompute=[true, false, true, false, true];
    fileprivate var delta:Double=0.000000000001;
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

    func testComputeMatchintResult() {
        XCTAssertEqual(1.3125, StringMatching.computeMatchintResult(resultCompute))
    }
    
    func testMatching() {
        XCTAssertEqual(resultMatching, StringMatching.matching(source, expression)!)
    }
}
