//
//  CachePoolTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/28.
//
//

import XCTest
@testable import ChineseSearch

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
    
    func testInitSingletonCaches() {//283.472s
        CachePool.instance.initSingletonCaches()
        let cacheNames = [CacheNames.PINYIN_WORD, CacheNames.PINYIN_WORDS, CacheNames.WUBI_WORD, CacheNames.WUBI_WORDS]
        let dkArr = ["sg", "sg", "sg", "sg"]
        for (index, cacheName) in cacheNames.enumerate() {
            XCTAssertNotNil(CachePool.instance.getCache(cacheName))
            printInfo(CachePool.instance.getCache(cacheName) as! ChineseCacheProtocol, dimensionKey: dkArr[index])
        }
        XCTAssertNotNil(CachePool.instance.getCache(CacheNames.WEIGHT))
    }
    
    func printInfo(cc: ChineseCacheProtocol, dimensionKey: String) {
        printSomeFromCache(cc, dimensionKey)
        printCache(cc);
    }
    
    func printCache(cc: ChineseCacheProtocol) {
        print(cc)
    }
    
    func printSomeFromCache(cc: ChineseCacheProtocol, _ dimensionKey: String) {
        let keyList = cc.getKeys(dimensionKey)
        var sb = ""
        sb.appendContentsOf("\(cc.getCacheName()): \(keyList.count)\n")
        for key in keyList {
            sb.appendContentsOf(" \(key)")
        }
        sb.appendContentsOf("\n")
        print(sb)
    }
    
    func testWordsWeight() {
        // 一一=1
        // 一丁点=0.1
        // 一丁点儿=1.06
        // 一万=5
        // 一丈=9
        // 一下=1.0
        let test = ["一一", "一丁点", "一丁点儿", "一万", "一丈", "一下"]
        let result = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
        let wc = CachePool.instance.getCache(CacheNames.WEIGHT) as? WeightCacheProtocol
        XCTAssertNotNil(wc)
        for (index, key) in test.enumerate() {
            XCTAssertEqual(wc!.getValues(key), result[index])
        }
    }
    
    func testIntegrity() {
        var sb = "CachePoolTest.testIntegrity() " + "测试汉字完成性，共\(0x9fa5 - 0x4e00 + 1)个汉字！\n"
        let cc0 = CachePool.instance.getCache(CacheNames.WUBI_WORD) as! ChineseCacheProtocol
        let cc1 = CachePool.instance.getCache(CacheNames.PINYIN_WORD) as! ChineseCacheProtocol
        let ccArr = [cc0, cc1]
        for cc in ccArr {
            var i = 0
            sb.appendContentsOf("\t\(cc.getCacheName())中无编码总数:")
            var newSB = ""
            let cString = ""
            for c in 0x4e00 ... 0x9fa5 {
                let key: String = String(stringInterpolationSegment : UnicodeScalar(c))
                if !cc.isKey(key) {
                    ++i
                    newSB.appendContentsOf("[\(key),\(cString.stringByAppendingFormat("%x", c))]")
                }
            }
            sb.appendContentsOf("\(i)个。如下:\n")
            sb.appendContentsOf("\t" + newSB)
            sb.appendContentsOf("\n————————————end\n")
        }
        print(sb)
    }
}
