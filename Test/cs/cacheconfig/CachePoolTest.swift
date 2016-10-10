//
//  CachePoolTest.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/28.
//
//

import XCTest
@testable import SearchKit

class CachePoolTest: XCTestCase {
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
    
    func testKeywordsCaches(){//257.390s
        CacheConfig.instance.supplyPinyinWordsConfig()
        CacheConfig.instance.supplyWubiWordsConfig()
        let cacheNames = [CacheNames.PINYIN_WORDS, CacheNames.WUBI_WORDS]
        let dkArr = ["sg", "sg"]
        for (index, cacheName) in cacheNames.enumerated() {
            XCTAssertNotNil(CachePool.instance.getCache(cacheName))
            printInfo(CachePool.instance.getCache(cacheName) as! ChineseCacheProtocol, dimensionKey: dkArr[index])
        }
    }
    
    func testCharacterLibraryCaches() {//1.345s
        let cacheNames = [CacheNames.PINYIN_WORD, CacheNames.WUBI_WORD]
        let size = [20807, 6791]
        for (index, cacheName) in cacheNames.enumerated() {
            XCTAssertNotNil(CachePool.instance.getCache(cacheName))
            let clp = CachePool.instance.getCache(cacheName) as! CharacterLibraryProtocol
            XCTAssertEqual(size[index], clp.keysSize)
        }
    }
    
    func printInfo(_ cc: ChineseCacheProtocol, dimensionKey: String) {
        printCache(cc)
        printSomeFromCache(cc, dimensionKey)
    }
    
    func printCache(_ cc: ChineseCacheProtocol) {
        print(cc)
    }
    
    func printSomeFromCache(_ cc: ChineseCacheProtocol, _ dimensionKey: String) {
        let keyList = cc.getKeys(dimensionKey)
        var sb = ""
        sb.append("\(cc.cacheName): \(keyList.count)\n")
        sb.append("\(keyList)\n")
        print(sb)
    }
    
    func testWordsWeight() {//3.892s, 3.160s
        // 一一=1
        // 一丁点=0.1
        // 一丁点儿=1.06
        // 一万=5
        // 一丈=9
        // 一下=1.0
        CacheConfig.instance.supplyWeightWordsConfig()
        let test = ["一一", "一丁点", "一丁点儿", "一万", "一丈", "一下"]
        let result = [1.0, 1.0, 1.06, 5, 9, 1.0]
        let wc = CachePool.instance.getCache(CacheNames.WEIGHT) as? WeightCacheProtocol
        XCTAssertNotNil(wc)
        for (index, key) in test.enumerated() {
            XCTAssertEqual(wc!.getValues(key), result[index])
        }
    }
    
    func testIntegrity() {
        var sb = "CachePoolTest.testIntegrity() " + "测试汉字完成性，共\(0x9fa5 - 0x4e00 + 1)个汉字！\n"
        let cc0 = CachePool.instance.getCache(CacheNames.WUBI_WORD) as! CharacterLibraryProtocol
        let cc1 = CachePool.instance.getCache(CacheNames.PINYIN_WORD) as! CharacterLibraryProtocol
        let ccArr = [cc0, cc1]
        for cc in ccArr {
            var i = 0
            sb.append("\t\(cc.cacheName)中无编码总数:")
            var newSB = ""
            let cString = ""
            for c in 0x4e00 ... 0x9fa5 {
                let key: String = String(stringInterpolationSegment : UnicodeScalar(c))
                if !cc.isKey(key) {
                    i += 1
                    newSB.append("[\(key),\(cString.appendingFormat("%x", c))]")
                }
            }
            sb.append("\(i)个。如下:\n")
            sb.append("\t" + newSB)
            sb.append("\n————————————end\n")
        }
        print(sb)
    }
}
