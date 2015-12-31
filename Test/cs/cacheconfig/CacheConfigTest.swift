//
//  CacheConfigTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/31.
//
//

import XCTest
@testable import ChineseSearch

class CacheConfigTest: XCTestCase {
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

    func testSingleton() {
        XCTAssertNotNil(CacheConfig.instance.getCacheInfo(CacheNames.PINYIN_WORD)?.reflectClass)
        XCTAssertNotNil(CacheConfig.instance.getCacheInfo(CacheNames.PINYIN_WORDS)?.reflectClass)
        XCTAssertNotNil(CacheConfig.instance.getCacheInfo(CacheNames.WUBI_WORD)?.reflectClass)
        XCTAssertNotNil(CacheConfig.instance.getCacheInfo(CacheNames.WUBI_WORDS)?.reflectClass)
        XCTAssertNotNil(CacheConfig.instance.getCacheInfo(CacheNames.WEIGHT)?.reflectClass)
    }
}
