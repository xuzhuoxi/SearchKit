//
//  ExStringTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/25.
//
//

import XCTest
@testable import ChineseSearch

class ExStringTest: XCTestCase {
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
    
    func testExplode() {
        let sources = ["","abcd","\u{4e00}\u{4e00}\u{4e00}"]
        let results = [[],["a","b","c","d"],["\u{4e00}","\u{4e00}","\u{4e00}"]]
        for (index, str) in sources.enumerate() {
            XCTAssertEqual(results[index], str.explode())
        }
    }
}
