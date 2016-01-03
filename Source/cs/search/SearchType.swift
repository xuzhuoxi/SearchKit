//
//  SearchType.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public struct SearchType : Hashable {
    private static var index: Int = 1000
    private let value: Int!
    
    public init(){
        self.value = SearchType.index++
    }
    
    init(_ value: Int) {
        self.value = value
    }
    
    public var hashValue: Int {
        return value
    }
    
    /**
     * 拼音，字库
     */
    public static let PINYIN_WORD = SearchType(1)
    
    /**
     * 五笔，字库
     */
    public static let WUBI_WORD = SearchType(2)
}

public func ==(lhs: SearchType, rhs: SearchType) -> Bool {
    return lhs.hashValue == rhs.hashValue
}