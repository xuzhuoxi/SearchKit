//
//  PinyinCodingImplTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/31.
//
//

import XCTest
@testable import ChineseSearch

class PinyinCodingImplTest: XCTestCase {
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

    func testCoding() {
        let impl = PinyinCodingImpl()
        let testAry = ["一", "丘", "之", "貉", "一丘之貉"]
        let result = [["yi"],["qiu"],["zhi"],["ma", "he", "hao", "mo"],["yi qiu zhi ma", "yi qiu zhi he", "yi qiu zhi hao", "yi qiu zhi mo"]]
        let cc = CachePool.instance.getCache(CacheNames.PINYIN_WORD) as! ChineseCacheProtocol
        for (index, str) in testAry.enumerate() {
            let coded = impl.coding(cc, words: str)
            XCTAssertNotNil(coded)
            XCTAssertEqual(result[index], coded!)
        }
    }
}
