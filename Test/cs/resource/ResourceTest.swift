//
//  ResourceTest.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/27.
//
//

import XCTest
@testable import ChineseSearch

class ResourceTest: XCTestCase {
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
    
    func testPerformance() {
        self.measureBlock{
            self.testGetResourceByAbsolutePath()
        }
    }
    
    func testGetResourceByAbsolutePath() {//平均：11.336s默认 8.419s-O-whole (Java平均时间：0.16s)
        var paths: [String] = []
        paths.append(ResourcePaths.PATH_PINYIN_WORD)//绝对路径
        paths.append(ResourcePaths.PATH_PINYIN_WORDS)//绝对路径
        paths.append(ResourcePaths.PATH_WUBI_WORD)//绝对路径
        paths.append(ResourcePaths.PATH_WUBI_WORDS)//绝对路径
        paths.append(ResourcePaths.PATH_WEIGHT_WORDS)//绝对路径
        let result = [20808, 90679, 6791, 90674, 90680]
        for (index, path) in paths.enumerate() {
            let resource = Resource.getResource(path)
            XCTAssertNotNil(resource)
            XCTAssertEqual(resource?.size, result[index])
        }
    }
    
    func testGetResourceByData() {
        let data:String="一一=yiy#yiyi#yy#yyi\n一丁点=ydd#yddian#ydingd#ydingdian#yidd#yiddian#yidingd#yidingdian"
        let count = 2
        let keys = ["一一", "一丁点"]
        let values = ["yiy#yiyi#yy#yyi", "ydd#yddian#ydingd#ydingdian#yidd#yiddian#yidingd#yidingdian"]
        let rs:Resource=Resource.getResourceByData(data)!
        XCTAssertEqual(rs.size, count)
        for i in 0 ..< rs.size {
            XCTAssertEqual(keys[i], rs.getKey(i))
            XCTAssertEqual(values[i], rs.getValue(i))
        }
    }
}
