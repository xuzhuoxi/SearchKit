//
//  ChineseCacheTest.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/28.
//
//

import XCTest
@testable import SearchKit

class ChineseCacheTest: XCTestCase {
//
//    override func setUp() {
//        super.setUp()
//         Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        print("tearDown")
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

    func testWordsWubi() {//245.866s, 33.214s, 36.857s, 32.807s
        let path:String=ResourcePaths.PATH_WUBI_WORDS
        let resource = Resource.getResource(path)!
        let cc = ChineseCache.createChineseCache(CacheNames.WUBI_WORDS, resource: resource, valueCodingType: ValueCodingType.wubi_WORDS)
        traceInfo(cc, key: "sg", desc: "ChineseCacheTest.testWordsWubi()")
    }
    
    func testWordsPinyin() {//1864.972s, 230.804s, 255.562s, 227.777s
        let path:String=ResourcePaths.PATH_PINYIN_WORDS
        let resource = Resource.getResource(path)!
        let cc = ChineseCache.createChineseCache(CacheNames.PINYIN_WORDS, resource: resource, valueCodingType: ValueCodingType.pinyin_WORDS)
        traceInfo(cc, key: "sg", desc: "ChineseCacheTest.testWordsPinyin()")
    }
    
    fileprivate func traceInfo(_ cc : ChineseCacheProtocol, key : String, desc : String) {
        let result = cc.getKeys(key)
        print(desc + ":[keysSize:\(cc.keysSize),resultCount:\(result.count)]")
        print("\(result)\n")
    }
}
