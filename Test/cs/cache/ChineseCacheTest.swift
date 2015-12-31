//
//  ChineseCacheTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/28.
//
//

import XCTest
@testable import ChineseSearch

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

    func testWordWubi() {//4.470s
        let path:String=ResourcePath.PATH_WUBI_WORD
        let resource = Resource.getResource(path)!
        let cc = ChineseCache.createChineseCache(CacheNames.WUBI_WORD, resource: resource, valueCodingType: ValueCodingType.WUBI_WORD)
        traceInfo(cc, key: "sg", desc: "ChineseCacheTest.testWordWubi()")
    }
    
    func testWordsWubi() {//245.866s
        let path:String=ResourcePath.PATH_WUBI_WORDS
        let resource = Resource.getResource(path)!
        let cc = ChineseCache.createChineseCache(CacheNames.WUBI_WORDS, resource: resource, valueCodingType: ValueCodingType.WUBI_WORDS)
        traceInfo(cc, key: "sg", desc: "ChineseCacheTest.testWordsWubi()")
    }
    
    func testWordPinyin() {//39.519s
        let path:String=ResourcePath.PATH_PINYIN_WORD
        let resource = Resource.getResource(path)!
        let cc = ChineseCache.createChineseCache(CacheNames.PINYIN_WORD, resource: resource, valueCodingType: ValueCodingType.PINYIN_WORD)
        traceInfo(cc, key: "sg", desc: "ChineseCacheTest.testWordPinyin()")
    }
    
    func testWordsPinyin() {//1864.972s
        let path:String=ResourcePath.PATH_PINYIN_WORDS
        let resource = Resource.getResource(path)!
        let cc = ChineseCache.createChineseCache(CacheNames.PINYIN_WORDS, resource: resource, valueCodingType: ValueCodingType.PINYIN_WORDS)
        traceInfo(cc, key: "sg", desc: "ChineseCacheTest.testWordsPinyin()")
    }
    
    private func traceInfo(cc : ChineseCacheProtocol, key : String, desc : String) {
        let result = cc.getKeys(key)
        print(desc + ":[keysSize:\(cc.getKeysSize()),resultCount:\(result.count)]")
        print("\(result)\n")
    }
}
