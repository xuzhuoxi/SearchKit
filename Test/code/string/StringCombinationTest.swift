//
//  StringCombinationTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/25.
//
//

import XCTest
@testable import ChineseSearch

class StringCombinationTest: XCTestCase {
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

    func testGetTwoDimensionArray() {
        let source = "adede"
        let sourceArr = source.explode()
        let rs1repeat = ["a", "d", "e", "d", "e"]
        let rs2repeat = ["a", "d", "e", "d", "e", "ad", "ae", "ad", "ae", "de", "dd", "de", "ed", "ee", "de"]
        let rs3repeat = ["a", "d", "e", "d", "e", "ad", "ae", "ad", "ae", "de", "dd", "de", "ed", "ee", "de", "ade", "add", "ade", "aed", "aee", "ade", "ded", "dee", "dde", "ede"]
        let rs1 = ["a", "d", "e"]
        let rs2 = ["a", "d", "e", "ad", "ae", "de", "dd", "ed", "ee"]
        let rs3 = ["a", "d", "e", "ad", "ae", "de", "dd", "ed", "ee", "ade", "add", "aed", "aee", "ded", "dee", "dde", "ede"]
        var dArr = [1, 2, 3]
        var resultRepeatArr = [rs1repeat, rs2repeat, rs3repeat]
        var resultArr = [rs1, rs2, rs3]
        XCTAssertEqual(resultRepeatArr.count, dArr.count)
        XCTAssertEqual(resultArr.count, dArr.count)
        for i in 0 ..< 3 {
            let d: Int = dArr[i]
            let resultRepeat = resultRepeatArr[i]
            let result = resultArr[i]
            XCTAssertEqual(resultRepeat, ArrayUtils.dimensionalityReduction(StringCombination.getTwoDimensionArray(sourceArr, dimensionValue: d, isRepeat: true)!))
            XCTAssertEqual(result, ArrayUtils.dimensionalityReduction(StringCombination.getTwoDimensionArray(sourceArr, dimensionValue: d, isRepeat: false)!))
            XCTAssertEqual(resultRepeat, StringCombination.getDimensionCombinationArray(sourceArr, dimensionValue: d, isRepeat: true)!)
            XCTAssertEqual(result, StringCombination.getDimensionCombinationArray(sourceArr, dimensionValue: d, isRepeat: false)!)
        }
    }
}
