//
//  FixedDimensionMapTest.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/27.
//
//

import XCTest
@testable import SearchKit

class FixedDimensionMapTest: XCTestCase {
    let keyCode : [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
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
    
    func assertTuplesEqual(_ tuples0: (Int, Int, Int), _ tuples1: (Int, Int, Int)) {
        XCTAssertEqual(tuples0.0, tuples1.0)
        XCTAssertEqual(tuples0.1, tuples1.1)
        XCTAssertEqual(tuples0.2, tuples1.2)
    }
    
    func testInfo() {
        let dimension = [1, 2]
        let result = [(1,26,0), (2,702,0)]
        for (index, d) in dimension.enumerated() {
            assertTuplesEqual(FixedDimensionMapImpl(charList: keyCode, dimension: d)!.dimensionInfo, result[index])
        }
    }
    
    func testAdd() {
        let mdMap = FixedDimensionMapImpl(charList: keyCode, dimension: 1)!
        let source = [["a":["a","ad","ac","ae"]], ["z":["z","zd","zc","ze"]]]
        let result = (1, 26, 8)
        for d in source {
            for k in d.keys {
                for v in d[k]! {
                    mdMap.add(k, dimensionValue: v)
                }
            }
        }
        assertTuplesEqual(result, mdMap.dimensionInfo)
        mdMap.add("a", dimensionValue: "a")
        assertTuplesEqual(result, mdMap.dimensionInfo)
    }
    
    func testGet() {
        let mdMap = FixedDimensionMapImpl(charList: keyCode, dimension: 1)!
        let result : Set<String> = ["a", "ad", "ac", "ae"]
        for str in result {
            mdMap.add("a", dimensionValue: str)
        }
        let getResult = mdMap.get("a")
        XCTAssertNotNil(getResult)
        XCTAssertEqual(getResult!.count, result.count)
        for value in result {
            XCTAssertTrue(getResult!.contains(value))
        }
    }
}
