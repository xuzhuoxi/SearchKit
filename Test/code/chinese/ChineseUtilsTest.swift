//
//  ChineseUtilsTest.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/25.
//
//

import XCTest
@testable import SearchKit

class ChineseUtilsTest: XCTestCase {
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
    
    func test0IsChinese() {
        let chs:[Character]=["a", "你", "，"]
        let rs=[false, true, false]
        XCTAssertEqual(chs.count, rs.count)
        for (i, str) in chs.enumerated() {
            XCTAssertEqual(ChineseUtils.isChinese(str), rs[i])
        }
    }
    
    func test1HasChinese() {
        let testStr=["你", "a你", "你a", "a你a", "你你", "a你你", "你你a", "a你你a", "你a你", "", "b"]
        let rs=[true, true, true, true, true, true, true, true, true, false, false]
        XCTAssertEqual(testStr.count, rs.count)
        for (i, str) in testStr.enumerated() {
            XCTAssertEqual(ChineseUtils.hasChinese(str), rs[i])
        }
    }
    
    func test2GetChineseIndexs() {
        let testStr = ["你", "a你", "你a", "a你a", "你你", "a你你", "你你a", "a你你a", "你a你", "", "b"]
        let rs:[[Int]] = [[0], [1], [0], [1], [0, 1], [1, 2], [0, 1], [1, 2], [0, 2], [], []]
        XCTAssertEqual(testStr.count, rs.count)
        for (i, str) in testStr.enumerated() {
            let result = ChineseUtils.getChineseIndexs(str)
            XCTAssertEqual(result, rs[i])
        }
    }
    
    func test3IsPinyinChar() {
        let chs:[Character]=["a", "你", "，"]
        let rs=[true, false, false]
        XCTAssertEqual(chs.count, rs.count)
        for (i, str) in chs.enumerated() {
            XCTAssertEqual(ChineseUtils.isPinyinChar(str), rs[i])
        }
    }
    
    func test3IsWubiChar() {
        let chs:[Character]=["a", "你", "，", "z"]
        let rs=[true, false, false, false]
        XCTAssertEqual(chs.count, rs.count)
        for (i, str) in chs.enumerated() {
            XCTAssertEqual(ChineseUtils.isWubiChar(str), rs[i])
        }
    }
    
    func test4ToChineseWordsRegexp() {
        let testStr=["你", "a你", "你a", "a你a", "你你", "a你你", "你你a", "a你你a", "你ab你"]
        let rs=["^你[\u{4e00}-\u{9fa5}]*$", "^[\u{4e00}-\u{9fa5}]*你[\u{4e00}-\u{9fa5}]*$", "^你[\u{4e00}-\u{9fa5}]*$", "^[\u{4e00}-\u{9fa5}]*你[\u{4e00}-\u{9fa5}]*$", "^你你[\u{4e00}-\u{9fa5}]*$", "^[\u{4e00}-\u{9fa5}]*你你[\u{4e00}-\u{9fa5}]*$", "^你你[\u{4e00}-\u{9fa5}]*$", "^[\u{4e00}-\u{9fa5}]*你你[\u{4e00}-\u{9fa5}]*$", "^你[\u{4e00}-\u{9fa5}]*你[\u{4e00}-\u{9fa5}]*$"]
        XCTAssertEqual(testStr.count, rs.count)
        for (i, str) in testStr.enumerated() {
            XCTAssertEqual(ChineseUtils.toChineseWordsRegexp(str), rs[i])
        }
    }
}
