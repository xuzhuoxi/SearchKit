//
//  MathUtilsTest.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/25.
//
//

import XCTest
@testable import SearchKit

class MathUtilsTest: XCTestCase {
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
    
    func testGetCombinationCount() {
        let len:[Int]=[5, 4, 3]
        let d:[Int]=[1, 2, 3]
        let r:[Int]=[5, 10, 10, 4, 6, 4, 3, 3, 1]
        var i: Int = 0
        for l in len {
            for v in d {
                let rs:Int = MathUtils.getCombinationCount(l, v)
                XCTAssertEqual(rs, r[i])
                i += 1
            }
        }
    }
    
    func testGetDimensionCombinationIndex() {
        let result: [[[Int]]] = [[[0],[1],[2],[3],[4]],
            [[0,1],[0,2],[0,3],[0,4],[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]],
            [[0,1,2],[0,1,3],[0,1,4],[0,2,3],[0,2,4],[0,3,4],[1,2,3],[1,2,4],[1,3,4],[2,3,4]]]
        let rs = MathUtils.getDimensionCombinationIndex(5, dimension: 3)!
        for (index0, arrs) in rs.enumerated() {
            for (index1, arr) in arrs.enumerated() {
                XCTAssertEqual(arr, result[index0][index1])
            }
        }
    }
    
    func testTenToCustomSystem() {
        let result = [[0,0,0,0,0],[1,0,0,0,0],[2,0,0,0,0],[0,1,0,0,0],[1,1,0,0,0],[2,1,0,0,0],[0,0,1,0,0],[1,0,1,0,0],[2,0,1,0,0],[0,1,1,0,0],[1,1,1,0,0],[2,1,1,0,0],[0,0,2,0,0],[1,0,2,0,0],[2,0,2,0,0],[0,1,2,0,0],[1,1,2,0,0],[2,1,2,0,0],[0,0,3,0,0],[1,0,3,0,0],[2,0,3,0,0],[0,1,3,0,0],[1,1,3,0,0],[2,1,3,0,0],[0,0,4,0,0],[1,0,4,0,0],[2,0,4,0,0],[0,1,4,0,0],[1,1,4,0,0],[2,1,4,0,0],[0,0,0,1,0],[1,0,0,1,0],[2,0,0,1,0],[0,1,0,1,0],[1,1,0,1,0],[2,1,0,1,0],[0,0,1,1,0],[1,0,1,1,0],[2,0,1,1,0],[0,1,1,1,0],[1,1,1,1,0],[2,1,1,1,0],[0,0,2,1,0],[1,0,2,1,0],[2,0,2,1,0],[0,1,2,1,0],[1,1,2,1,0],[2,1,2,1,0],[0,0,3,1,0],[1,0,3,1,0],[2,0,3,1,0],[0,1,3,1,0],[1,1,3,1,0],[2,1,3,1,0],[0,0,4,1,0],[1,0,4,1,0],[2,0,4,1,0],[0,1,4,1,0],[1,1,4,1,0],[2,1,4,1,0],[0,0,0,0,1],[1,0,0,0,1],[2,0,0,0,1],[0,1,0,0,1],[1,1,0,0,1],[2,1,0,0,1],[0,0,1,0,1],[1,0,1,0,1],[2,0,1,0,1],[0,1,1,0,1],[1,1,1,0,1],[2,1,1,0,1],[0,0,2,0,1],[1,0,2,0,1],[2,0,2,0,1],[0,1,2,0,1],[1,1,2,0,1],[2,1,2,0,1],[0,0,3,0,1],[1,0,3,0,1],[2,0,3,0,1],[0,1,3,0,1],[1,1,3,0,1],[2,1,3,0,1],[0,0,4,0,1],[1,0,4,0,1],[2,0,4,0,1],[0,1,4,0,1],[1,1,4,0,1],[2,1,4,0,1],[0,0,0,1,1],[1,0,0,1,1],[2,0,0,1,1],[0,1,0,1,1],[1,1,0,1,1],[2,1,0,1,1],[0,0,1,1,1],[1,0,1,1,1],[2,0,1,1,1],[0,1,1,1,1],[1,1,1,1,1],[2,1,1,1,1],[0,0,2,1,1],[1,0,2,1,1],[2,0,2,1,1],[0,1,2,1,1],[1,1,2,1,1],[2,1,2,1,1],[0,0,3,1,1],[1,0,3,1,1],[2,0,3,1,1],[0,1,3,1,1],[1,1,3,1,1],[2,1,3,1,1],[0,0,4,1,1],[1,0,4,1,1],[2,0,4,1,1],[0,1,4,1,1],[1,1,4,1,1],[2,1,4,1,1],[0,0,0,0,2],[1,0,0,0,2],[2,0,0,0,2],[0,1,0,0,2],[1,1,0,0,2],[2,1,0,0,2],[0,0,1,0,2],[1,0,1,0,2],[2,0,1,0,2],[0,1,1,0,2],[1,1,1,0,2],[2,1,1,0,2],[0,0,2,0,2],[1,0,2,0,2],[2,0,2,0,2],[0,1,2,0,2],[1,1,2,0,2],[2,1,2,0,2],[0,0,3,0,2],[1,0,3,0,2],[2,0,3,0,2],[0,1,3,0,2],[1,1,3,0,2],[2,1,3,0,2],[0,0,4,0,2],[1,0,4,0,2],[2,0,4,0,2],[0,1,4,0,2],[1,1,4,0,2],[2,1,4,0,2],[0,0,0,1,2],[1,0,0,1,2],[2,0,0,1,2],[0,1,0,1,2],[1,1,0,1,2],[2,1,0,1,2],[0,0,1,1,2],[1,0,1,1,2],[2,0,1,1,2],[0,1,1,1,2],[1,1,1,1,2],[2,1,1,1,2],[0,0,2,1,2],[1,0,2,1,2],[2,0,2,1,2],[0,1,2,1,2],[1,1,2,1,2],[2,1,2,1,2],[0,0,3,1,2],[1,0,3,1,2],[2,0,3,1,2],[0,1,3,1,2],[1,1,3,1,2],[2,1,3,1,2],[0,0,4,1,2],[1,0,4,1,2],[2,0,4,1,2],[0,1,4,1,2],[1,1,4,1,2],[2,1,4,1,2],[0,0,0,0,3],[1,0,0,0,3],[2,0,0,0,3],[0,1,0,0,3],[1,1,0,0,3],[2,1,0,0,3],[0,0,1,0,3],[1,0,1,0,3],[2,0,1,0,3],[0,1,1,0,3],[1,1,1,0,3],[2,1,1,0,3],[0,0,2,0,3],[1,0,2,0,3],[2,0,2,0,3],[0,1,2,0,3],[1,1,2,0,3],[2,1,2,0,3],[0,0,3,0,3],[1,0,3,0,3],[2,0,3,0,3],[0,1,3,0,3],[1,1,3,0,3],[2,1,3,0,3],[0,0,4,0,3],[1,0,4,0,3],[2,0,4,0,3],[0,1,4,0,3],[1,1,4,0,3],[2,1,4,0,3],[0,0,0,1,3],[1,0,0,1,3],[2,0,0,1,3],[0,1,0,1,3],[1,1,0,1,3],[2,1,0,1,3],[0,0,1,1,3],[1,0,1,1,3],[2,0,1,1,3],[0,1,1,1,3],[1,1,1,1,3],[2,1,1,1,3],[0,0,2,1,3],[1,0,2,1,3],[2,0,2,1,3],[0,1,2,1,3],[1,1,2,1,3],[2,1,2,1,3],[0,0,3,1,3],[1,0,3,1,3],[2,0,3,1,3],[0,1,3,1,3],[1,1,3,1,3],[2,1,3,1,3],[0,0,4,1,3],[1,0,4,1,3],[2,0,4,1,3],[0,1,4,1,3],[1,1,4,1,3],[2,1,4,1,3]]
        let system=[3, 2, 5, 2, 4]
        for i in 0 ..< 240 {
            let value = MathUtils.tenToCustomSystem(i, system)
            XCTAssertEqual(result[i], value)
        }
    }
}
