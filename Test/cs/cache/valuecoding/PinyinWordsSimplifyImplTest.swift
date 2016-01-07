//
//  PinyinWordsSimplifyImplTest.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/27.
//
//

import XCTest
@testable import SearchKit

class PinyinWordsSimplifyImplTest: XCTestCase {
    private let strategy : ValueCodingStrategyProtocol = PinyinWordsStrategyImpl()
    
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
    
//    func test() {
//        // 幸免于难=nie mian xu nan#xing mian xu nan#nie wan xu nan#xing wan xu
//        // nan#nie wen xu nan#xing wen xu nan#nie mian yu nan#xing mian yu
//        // nan#nie wan yu nan#xing wan yu nan#nie wen yu nan#xing wen yu nan#nie
//        // mian xu nuo#xing mian xu nuo#nie wan xu nuo#xing wan xu nuo#nie wen
//        // xu nuo#xing wen xu nuo#nie mian yu nuo#xing mian yu nuo#nie wan yu
//        // nuo#xing wan yu nuo#nie wen yu nuo#xing wen yu nuo
//        let value:String="nie mian xu nan#xing mian xu nan#nie wan xu nan#xing wan xu nan#nie wen xu nan#xing wen xu nan#nie mian yu nan#xing mian yu nan#nie wan yu nan#xing wan yu nan#nie wen yu nan#xing wen yu nan#nie mian xu nuo#xing mian xu nuo#nie wan xu nuo#xing wan xu nuo#nie wen xu nuo#xing wen xu nuo#nie mian yu nuo#xing mian yu nuo#nie wan yu nuo#xing wan yu nuo#nie wen yu nuo#xing wen yu nuo"
//        let values = value.componentsSeparatedByString("#")
//        print("PinyinWordsSimplifyImplTest.enclosing_method(enclosing_method_arguments): \(values.count)")
//        for singleValue in values {
//            let sValue = self.strategy.getSimplifyValue(singleValue)
//            print("[\(singleValue)][\(sValue)]")
//            let sValues = self.strategy.getDimensionKeys(sValue)
//            print("\(sValues)\n")
//        }
//    }
    
    func testCompute() {
        let source = ["nie mian xu nan","nmnxnn"]
        let keys = ["n", "nm", "nn", "nx"]
        XCTAssertEqual(self.strategy.getSimplifyValue(source[0]), source[1])
        XCTAssertEqual(self.strategy.getDimensionKeys(source[1]), keys)
    }
    
    func testPerformance() {
        let path = ResourcePaths.PATH_PINYIN_WORDS
        let resource = Resource.getResource(path)!
//        self.timeGetDimensionKeys(resource, count: Int.max)
        self.measureBlock{
//            self.timeGetDimensionKeys(resource, count: 500) //4.879s, 4.852s, 4.803s, 5.009s (优化全开0.022s)
//            self.timeGetDimensionKeys(resource, count: 1000) //6.066s, 5.795s, 5.846s, 5.782s (优化全开0.043s)
//            self.timeGetDimensionKeys(resource, count: 10000) //13.703s, 13.713s, 13.986s, 13.601s (优化全开0.457s)
            self.timeGetDimensionKeys(resource, count: Int.max) //编译优化全开后7.5s左右(现在4.204s, 4.197s, 5.238)
        }
    }
    
    func timeGetDimensionKeys(resource: Resource, count: Int) {
        let size = min(resource.size, count)
        for index in 0 ..< size {
            self.strategy.getDimensionKeys(self.strategy.getSimplifyValue(resource.getValue(index)))
        }
    }
}
