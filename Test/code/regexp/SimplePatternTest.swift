//
//  SimplePatternTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/26.
//
//

import XCTest
@testable import ChineseSearch

class SimplePatternTest: XCTestCase {
//
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

    func testSimple(){
        let source = "abcd"
        let patternArr = ["[a-z]", "^[a-z]*$"]
        let result = [4, 1]
        for (index, pattern) in patternArr.enumerate() {
            let p = SimplePattern(pattern)
            XCTAssertEqual(p.getMatchCount(source), result[index])
        }
    }
    
    func testInteger() {
        let REGEX_INTEGER: String = "^[\\-\\+]?([1-9]\\d*|0)$"
        let source = ["465","0","-246","1.245"]
        let result = [true, true, true, false]
        let p = SimplePattern(REGEX_INTEGER)
        for (index, str) in source.enumerate() {
            XCTAssertEqual(p.isMatch(str), result[index])
        }
    }
    
    func testFloat1More() {
        let REGEX_FLOAT_1MORE: String = "^\\+?([1-9]\\d*.\\d*|[1-9]\\d*)$"
        let source = ["1.23","-246","0","adh"]
        let result = [true, false, false, false]
        let p = SimplePattern(REGEX_FLOAT_1MORE)
        for (index, str) in source.enumerate() {
            XCTAssertEqual(p.isMatch(str), result[index])
        }
    }
}
