//
//  StringUtilsTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/25.
//
//

import XCTest
@testable import ChineseSearch

class StringUtilsTest: XCTestCase {
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
    
    func testToNonRepeatString() {
        let str:String="abcddabcdd"
        let rs:String="abcd"
        XCTAssertEqual(StringUtils.toNonRepeatString(str), rs)
    }
    
    func testRemoveChars() {
        var sb:String="abcddabcdd"
        let indexs=[1, 3, 5]
        let rs:String="acdbcdd"
        sb=StringUtils.removeChars(sb, excludeIndex: indexs)
        XCTAssertEqual(sb, rs)
    }
    
    func testStructString() {
        let str:String="abcddabcdd"
        let indexs:Array=[1, 3, 2, 1]
        let rs:String="bdcb"
        XCTAssertEqual(StringUtils.structString(str, includeIndex: indexs), rs)
    }
    
    func testStructStringIgnore() {
        let str:String="abcddabcdd"
        let indexs:Array=[0, 3, 9, 10, -1]
        let rs:Array=["bcddabcdd", "abcdabcdd", "abcddabcd", "abcddabcdd", "abcddabcdd"]
        XCTAssertEqual(indexs.count, rs.count)
        for i in 0 ..< indexs.count {
            XCTAssertEqual(StringUtils.structString(str, ignoreIndex: indexs[i]), rs[i])
        }
    }
}
