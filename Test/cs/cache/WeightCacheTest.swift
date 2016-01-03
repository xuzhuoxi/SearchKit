//
//  WeightCacheTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/28.
//
//

import XCTest
@testable import ChineseSearch

class WeightCacheTest: XCTestCase {
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
    
    func test() {//3.179s
        let path:String=ResourcePaths.PATH_WEIGHT_WORDS
        let resource = Resource.getResource(path)!
        let wc = WeightCache.createWeightCache("wordsWeight", resource: resource)
        print(wc.getKeysSize())
        let weight = wc.getValues("一个巴掌拍不响")
        XCTAssertEqual(weight, 1.1)
    }
    
    func testInit() {
        let wc = WeightCacheImpl()
        let initProtocol = wc as CacheInitProtocol
        initProtocol.initCache(CacheNames.WEIGHT, nil, 16)
    }
}
