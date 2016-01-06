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
    public let rawValue: Int
    /**
     * 关联名称 用于最终结果后其它信息的连结
     *
     * @return
     */
    public let associatedName: String?
    
    public init(){
        self.rawValue = SearchType.index++
        self.associatedName = nil
    }
    
    public init(associatedName: String) {
        self.rawValue = SearchType.index++
        self.associatedName = associatedName
    }
    
    init(_ rawValue: Int, _ associatedName: String?) {
        self.rawValue = rawValue
        self.associatedName = associatedName
    }
    
    public var hashValue: Int {
        return rawValue
    }
    
    /**
     * 拼音，字库
     */
    public static let PINYIN_WORD = SearchType(1, nil)
    
    /**
     * 五笔，字库
     */
    public static let WUBI_WORD = SearchType(2, nil)
}

public func ==(lhs: SearchType, rhs: SearchType) -> Bool {
    return lhs.hashValue == rhs.hashValue
}