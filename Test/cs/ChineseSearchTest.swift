//
//  ChineseSearchTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 16/1/6.
//
//

import XCTest
import ChineseSearch

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
        var searchConfig = SearchConfig()
        searchConfig.addSearchType(SearchTypeInfo.WORD_PINYIN_SEARCH)
        let searcher = ChineseSearcherFactory.getChineseSearcher()
        XCTAssertNil(searcher.search("Q", searchConfig: searchConfig))
    }
}
