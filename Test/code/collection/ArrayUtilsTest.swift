//
//  ArrayUtilsTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/25.
//
//

import XCTest
@testable import ChineseSearch

class ArrayUtilsTest: XCTestCase {
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
    
    func test0CleanRepeat() {
        var cs=["a", "b", "c", "a", "b", "c"]
        let result=["a", "b", "c"]
        ArrayUtils.cleanRepeat(&cs)
        XCTAssertEqual(cs, result)
    }
    
    func test1DimensionalityReduction() {
        let result=[["a", "b"], ["c", "b"], ["a", "e"]]
        let result2=["a", "b", "c", "b", "a", "e"]
        XCTAssertEqual(result2, ArrayUtils.dimensionalityReduction(result))
    }
    
    func test2MergeArray() {
        let result=["a", "b", "c"]
        let result1=["a", "b"]
        let result2:[String]=[]
        let result3=["c"]
        XCTAssertEqual(result, ArrayUtils.mergeArray([result1,result2,result3]))
    }
}