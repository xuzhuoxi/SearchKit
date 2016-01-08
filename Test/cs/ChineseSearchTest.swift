//
//  SearchKitTest.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/6.
//
//

import XCTest
import SearchKit

class ChineseSearchTest: XCTestCase {

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
    
    func testSearch() {
        CacheConfig.instance.supplyWubiWordsConfig()
        CacheConfig.instance.supplyWeightWordsConfig()
        var searchConfig = SearchConfig()
        searchConfig.addSearchType(SearchTypeInfo.WUBI_WORDS_SEARCH)
        let searcher = ChineseSearcherFactory.getChineseSearcher()
        let resultKeys = ["您们","你们","低倍","低位","爷们"]
        let result = searcher.search("wqwu", searchConfig: searchConfig)
        XCTAssertNotNil(result)
        XCTAssertEqual(resultKeys.count, result!.resultsSize)
        var rks = [String]()
        for r in result!.sortedResults {
            rks.append(r.key)
        }
        XCTAssertEqual(rks, resultKeys)
    }
}
