//
//  SearchTypeResult.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 * 单个字(词)的单个检索类型结果
 *
 * @author xuzhuoxi
 *
 */
public class SearchTypeResult: Comparable {
    private static let fullMatchingValue: Double = 2.0
    
    private let searchType: SearchTypes
    private var value: Double = 0;
    
    public init(_ searchType: SearchTypes) {
        self.searchType = searchType
    }
    
    
    /**
    * 检索类型
    *
    * @return 检索类型
    */
    public final func getSearchType() ->SearchTypes{
        return searchType
    }
    
    /**
    * 检索结果
    *
    * @return 检索结果(匹配度)
    */
    public final func getValue() ->Double {
        return value
    }
    
    /**
    * 更新检索结果
    *
    * @param value
    *            检索结果(匹配度)
    *
    * @see #fullMatchingValue
    */
    public final func updateBiggerValue(value: Double) {
        if (value <= SearchTypeResult.fullMatchingValue && self.value < value) {
            self.value = value
        }
    }
    
    /**
    * 是否为全匹配
    *
    * @return 是true否false
    * @see #fullMatchingValue
    */
    public final func isFullMatching() ->Bool {
        return value >= SearchTypeResult.fullMatchingValue
    }
}

public func ==(lhs: SearchTypeResult, rhs: SearchTypeResult) -> Bool {
    return (lhs.isFullMatching() == rhs.isFullMatching()) && (lhs.getValue() == rhs.getValue())
}

public func <(lhs: SearchTypeResult, rhs: SearchTypeResult) -> Bool {
    if lhs.isFullMatching() != rhs.isFullMatching() {
        return lhs.isFullMatching() ? false : true
    } else {
        return lhs.getValue() < rhs.getValue()
    }
}
//
//public func >(lhs: SearchTypeResult, rhs: SearchTypeResult) -> Bool {
//    if lhs.isFullMatching() != rhs.isFullMatching() {
//        return lhs.isFullMatching() ? true : false
//    } else {
//        return lhs.getValue() > rhs.getValue()
//    }
//}
//
//public func <=(lhs: SearchTypeResult, rhs: SearchTypeResult) -> Bool {
//    return (lhs < rhs) || (lhs == rhs)
//}
//
//public func >=(lhs: SearchTypeResult, rhs: SearchTypeResult) -> Bool {
//    return (lhs > rhs) || (lhs == rhs)
//}
