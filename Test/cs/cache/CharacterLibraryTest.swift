//
//  CharacterLibraryTest.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/7.
//
//

import XCTest
@testable import SearchKit

class CharacterLibraryTest: XCTestCase {
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
    
    func testCharacterLibrary(){
        let wo = Character("我")
        let no = Character("丗")
        let cachePinyin = CachePool.instance.getCache(CacheNames.PINYIN_WORD) as! CharacterLibraryProtocol
        XCTAssertTrue(cachePinyin.isKey(wo))
        let cacheWubi = CachePool.instance.getCache(CacheNames.WUBI_WORD) as! CharacterLibraryProtocol
        XCTAssertFalse(cacheWubi.isKey(no))
    }
}
